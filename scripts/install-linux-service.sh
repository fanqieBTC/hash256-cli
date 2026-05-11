#!/usr/bin/env bash
set -euo pipefail

APP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SERVICE_NAME="${SERVICE_NAME:-hash256-miner}"
RUN_USER="${SUDO_USER:-$USER}"
NODE_BIN="$(command -v node || true)"

if [[ -z "$NODE_BIN" ]]; then
  echo "node is missing. Install Node.js first, then re-run this script."
  exit 1
fi

cd "$APP_DIR"

if [[ ! -f .env ]]; then
  cp .env.example .env
  echo "Created .env. Edit it with your RPC/private key first:"
  echo "  nano $APP_DIR/.env"
  exit 1
fi

npm install
npm run assets

sudo tee "/etc/systemd/system/${SERVICE_NAME}.service" >/dev/null <<EOF
[Unit]
Description=HASH256 transparent CLI miner
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
User=${RUN_USER}
WorkingDirectory=${APP_DIR}
Environment=NODE_ENV=production
EnvironmentFile=${APP_DIR}/.env
ExecStart=/usr/bin/env node hash256-cli.js mine --engine auto --submit --loop
Restart=always
RestartSec=10
Nice=10
CPUQuota=90%
SyslogIdentifier=${SERVICE_NAME}

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable --now "$SERVICE_NAME"

echo "Installed and started ${SERVICE_NAME}."
echo "Status:"
echo "  systemctl status ${SERVICE_NAME}"
echo "Logs:"
echo "  journalctl -u ${SERVICE_NAME} -f"
echo "Stop:"
echo "  sudo systemctl stop ${SERVICE_NAME}"
