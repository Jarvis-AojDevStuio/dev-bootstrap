#!/usr/bin/env bash
set -euo pipefail

echo "== WSL side setup =="

if command -v sudo >/dev/null 2>&1; then
  echo "Checking sudo access (you may be prompted once)..."
  if ! sudo -n true 2>/dev/null; then
    if ! sudo -v; then
      echo "Sudo is not available for this user."
      echo "If you need sudo, add your user to the sudo group (as root):"
      echo "  usermod -aG sudo $USER"
    fi
  fi
else
  echo "Sudo not found. Some setup steps may require root."
fi

if command -v apt-get >/dev/null 2>&1; then
  sudo apt-get update -y
  sudo apt-get install -y git curl ca-certificates
fi

# Claude Code install for Linux (per official docs):
# https://code.claude.com/docs/en/setup
curl -fsSL https://claude.ai/install.sh | bash

if ! grep -q "dev-bootstrap" ~/.bashrc 2>/dev/null; then
  cat >> ~/.bashrc <<'EOF'
# ---- dev-bootstrap (WSL) ----
export PATH="$HOME/.local/bin:$PATH"
# -----------------------------
EOF
fi

echo "WSL setup complete."
