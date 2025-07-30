#!/bin/bash

# === Load Environment Variables ===
set -a
source /root/docker/.env.backup || {
  echo "❌ Failed to load environment file"
  exit 1
}
set +a

# === Variables ===
DATE=$(date +%F)
BACKUP_DIR="/root/docker/db_backups/$DATE"
ARCHIVE_PATH="/root/docker/db_backups/db_backup_$DATE.tar.gz"
EMAIL="dev@landingpad.digital"
S3_BUCKET="s3://landingpad-digital/db_backups/"
GPG_RECIPIENT="$EMAIL"
TEMPLATE_PATH="/root/docker/email_templates/backup_error.html"
LOG_FILE="/root/docker/db_backup.log"

# === Logging ===
exec > >(tee -a "$LOG_FILE") 2>&1

echo "🕐 Starting backup process at $(date)"

# === Send Styled Error Email ===
send_error_email() {
  local ERROR_MSG="${1:-Unknown error}"
  local FAILED_COMMAND="${2:-N/A}"

  if [[ ! -r "$TEMPLATE_PATH" ]]; then
    echo "⚠️ Cannot read email template at $TEMPLATE_PATH" >&2
    return 1
  fi

  local EMAIL_BODY=$(<"$TEMPLATE_PATH")
  EMAIL_BODY=$(echo "$EMAIL_BODY" | sed -e "s|{{ERROR}}|$ERROR_MSG|g" \
                                        -e "s|{{HOSTNAME}}|$(hostname)|g" \
                                        -e "s|{{DATE}}|$(date)|g" \
                                        -e "s|{{COMMAND}}|$FAILED_COMMAND|g")

  {
    echo "From: $EMAIL"
    echo "To: $EMAIL"
    echo "Subject: ❌ Backup Error: $ERROR_MSG on $(hostname)"
    echo "Content-Type: text/html"
    echo ""
    echo "$EMAIL_BODY"
  } | msmtp "$EMAIL"
}

# === Send Slack Success Alert ===
send_slack_success() {
  if [[ -z "$SLACK_WEBHOOK_URL" ]]; then
    echo "⚠️ SLACK_WEBHOOK_URL not set, skipping Slack notification"
    return
  fi

  curl -s -X POST -H 'Content-type: application/json' \
    --data "{
      \"text\": \"✅ *Backup successful* on $(hostname) at $(date)\",
      \"username\": \"BackupBot\",
      \"icon_emoji\": \":floppy_disk:\"
    }" "$SLACK_WEBHOOK_URL"
}

# === Send Success Email ===
send_success_email() {
  {
    echo "From: $EMAIL"
    echo "To: $EMAIL"
    echo "Subject: ✅ Backup Successful on $(hostname)"
    echo "Content-Type: text/html"
    echo ""
    echo "<p><strong>Backup completed successfully</strong> on <em>$(hostname)</em> at $(date).</p>"
  } | msmtp "$EMAIL"
}

# === Run Command With Error Handling ===
run_backup_command() {
  local CMD="$1"
  local DESC="$2"
  echo "🔹 Running: $CMD"
  eval "$CMD"
  if [ $? -ne 0 ]; then
    send_error_email "$DESC" "$CMD"
    exit 1
  fi
}

# === Cleanup Old Backups (7 days retention) ===
find /root/docker/db_backups/ -maxdepth 1 -type d -mtime +7 -exec rm -rf {} \;
find /root/docker/db_backups/ -maxdepth 1 -name "*.tar.gz.gpg" -mtime +7 -exec rm -f {} \;

# === Create Backup Directory ===
mkdir -p "$BACKUP_DIR" || {
  send_error_email "Failed to create backup directory" "mkdir -p $BACKUP_DIR"
  exit 1
}

# === Begin Database Backups ===
echo "📦 Backing up databases..."

# Listmonk (PostgreSQL)
run_backup_command \
  "docker exec -t listmonk-db pg_dump -U \"$LISTMONK_DB_USER\" \"$LISTMONK_DB_NAME\" > \"$BACKUP_DIR/listmonk.sql\"" \
  "Listmonk Backup Failed"

# Chatwoot (PostgreSQL)
run_backup_command \
  "docker exec -t chatwoot_postgres pg_dump -U \"$CHATWOOT_DB_USER\" \"$CHATWOOT_DB_NAME\" > \"$BACKUP_DIR/chatwoot.sql\"" \
  "Chatwoot Backup Failed"

# Nextcloud (MariaDB)
run_backup_command \
  "docker exec cloud-db-1 sh -c 'mysqldump -u\"$NEXTCLOUD_DB_USER\" -p\"$NEXTCLOUD_DB_PASSWORD\" \"$NEXTCLOUD_DB_NAME\"' > \"$BACKUP_DIR/nextcloud.sql\"" \
  "Nextcloud Backup Failed"

# Matomo (MariaDB)
MATOMO_BACKUP_FILE="$BACKUP_DIR/matomo.sql"
> "$MATOMO_BACKUP_FILE"  # Truncate if exists
run_backup_command \
  "docker exec matomo-db sh -c '/usr/bin/mariadb-dump -u\"$MATOMO_DB_USER\" -p\"$MATOMO_DB_PASSWORD\" \"$MATOMO_DB_NAME\"' > \"$MATOMO_BACKUP_FILE\"" \
  "Matomo Backup Failed"

# Verify Matomo backup not empty
if [ ! -s "$MATOMO_BACKUP_FILE" ]; then
  send_error_email "Matomo backup file is empty" "Matomo SQL verification"
  exit 1
fi

# === Archive Backups ===
run_backup_command \
  "tar -czf \"$ARCHIVE_PATH\" -C \"$BACKUP_DIR\" ." \
  "Failed to archive backups"

# === Encrypt the Archive ===
run_backup_command \
  "gpg --yes --batch -o \"$ARCHIVE_PATH.gpg\" -r \"$GPG_RECIPIENT\" --encrypt \"$ARCHIVE_PATH\"" \
  "GPG Encryption Failed"

# === Upload to S3 ===
run_backup_command \
  "aws s3 cp \"$ARCHIVE_PATH.gpg\" \"$S3_BUCKET\"" \
  "S3 Upload Failed"

# === Cleanup Unencrypted Files ===
rm -f "$ARCHIVE_PATH"
rm -rf "$BACKUP_DIR"

# === Notify Success ===
send_success_email
send_slack_success

echo "✅ Backup completed and uploaded successfully at $(date)"
