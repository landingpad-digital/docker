# Landing Pad VPS Docker Stack

This repository contains the Docker setup for all web applications running on our VPS.

## 🧭 Directory Structure

```bash
.
├── email/             # Listmonk (Email marketing)
│   ├── docker-compose.yml
│   └── listmonk_config/
├── cloud/             # Nextcloud (File storage)
│   └── docker-compose.yml
├── chat/              # Chatwoot (Customer chat)
│   └── docker-compose.yml
├── uptime/            # Uptime Kuma (Monitoring)
│   └── docker-compose.yml
└── README.md


🚀 Getting Started
Each directory contains its own docker-compose.yml and config files. Navigate to a folder and run:
```bash
docker compose up -d