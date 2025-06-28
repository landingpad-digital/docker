#!/bin/bash

# Load .env values
set -a
source /root/docker/.env.backup
set +a

# Setup
DATE=$(date +%F)
BACKUP_DIR="/root/docker/db_backups/$DATE"
ARCHIVE_PATH="/root/docker/db_backups/db_backup_$DATE.tar.gz"
EMAIL="dev@landingpad.digital"
S3_BUCKET="s3://landingpad-digital/db_backups/"
GPG_RECIPIENT="dev@landingpad.digital"
TEMPLATE_PATH="/root/docker/email_templates/backup_error.html"

# Send styled error email
send_error_email() {
  local ERROR_MSG="${1:-Unknown error}"
  local FAILED_COMMAND="${2:-N/A}"

  if [[ ! -r "$TEMPLATE_PATH" ]]; then
    echo "⚠️ Cannot read email template at $TEMPLATE_PATH" >&2
    return 1
  fi

  EMAIL_BODY=$(<"$TEMPLATE_PATH")
  EMAIL_BODY=$(echo "$EMAIL_BODY" | sed -e "s|{{ERROR}}|$ERROR_MSG|g")
  EMAIL_BODY=$(echo "$EMAIL_BODY" | sed -e "s|{{HOSTNAME}}|$(hostname)|g")
  EMAIL_BODY=$(echo "$EMAIL_BODY" | sed -e "s|{{DATE}}|$(date)|g")
  EMAIL_BODY=$(echo "$EMAIL_BODY" | sed -e "s|{{COMMAND}}|$FAILED_COMMAND|g")

  {
    echo "From: $EMAIL"
    echo "To: $EMAIL"
    echo "Subject: ❌ Backup Error: $ERROR_MSG on $(hostname)"
    echo "Content-Type: text/html"
    echo ""
    echo "$EMAIL_BODY"
  } | msmtp "$EMAIL"
}

# Wrapper to execute command and handle errors
run_backup_command() {
  local CMD="$1"
  local DESC="$2"
  echo "🔹 Executing: $CMD"
  eval "$CMD"
  if [ $? -ne 0 ]; then
    send_error_email "$DESC" "$CMD"
    return 1
  fi
}

# Create backup dir
mkdir -p "$BACKUP_DIR" || send_error_email "Failed to create backup directory" "mkdir -p $BACKUP_DIR"

echo "🔄 Starting database backups..."

# --- BACKUP COMMANDS ---

# Listmonk (PostgreSQL)
run_backup_command \
  "docker exec -t listmonk-db pg_dump -U \"$LISTMONK_DB_USER\" \"$LISTMONK_DB_NAME\" > \"$BACKUP_DIR/listmonk.sql\"" \
  "Listmonk DB Backup Failed"

# Chatwoot (PostgreSQL)
run_backup_command \
  "docker exec -t chatwoot_postgres pg_dump -U \"$CHATWOOT_DB_USER\" \"$CHATWOOT_DB_NAME\" > \"$BACKUP_DIR/chatwoot.sql\"" \
  "Chatwoot DB Backup Failed"

# Nextcloud (MariaDB)
run_backup_command \
  "docker exec cloud-db-1 mysqldump -u\"$NEXTCLOUD_DB_USER\" -p\"$NEXTCLOUD_DB_PASSWORD\" \"$NEXTCLOUD_DB_NAME\" > \"$BACKUP_DIR/nextcloud.sql\"" \
  "Nextcloud DB Backup Failed"

# Matomo (MariaDB) - USING ABSOLUTE PATH
MATOMO_BACKUP_FILE="$BACKUP_DIR/matomo.sql"
> "$MATOMO_BACKUP_FILE"  # Clear existing file
run_backup_command \
  "docker exec matomo-db sh -c '/usr/bin/mariadb-dump -u\"matomo_user\" -p\"matomo_password\" \"matomo\"' > \"$MATOMO_BACKUP_FILE\"" \
  "Matomo DB Backup Failed"

# Verify Matomo backup was created
if [ ! -s "$MATOMO_BACKUP_FILE" ]; then
    send_error_email "Matomo backup file empty after dump" "mariadb-dump verification"
    exit 1
fi

# Archive all backups
run_backup_command \
  "tar -czf \"$ARCHIVE_PATH\" -C \"$BACKUP_DIR\" ." \
  "Archiving Backup Failed"

# Encrypt archive
run_backup_command \
  "gpg --yes --batch -o \"$ARCHIVE_PATH.gpg\" -r \"$GPG_RECIPIENT\" --encrypt \"$ARCHIVE_PATH\"" \
  "GPG Encryption Failed"

# Upload to S3
run_backup_command \
  "aws s3 cp \"$ARCHIVE_PATH.gpg\" \"$S3_BUCKET\"" \
  "S3 Upload Failed"

# Cleanup (only after successful upload)
rm -f "$ARCHIVE_PATH"
rm -rf "$BACKUP_DIR"

echo "✅ Backup complete and encrypted: $(basename "$ARCHIVE_PATH.gpg")"
