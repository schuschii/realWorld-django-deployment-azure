#!/bin/bash
set -e

# Load .env from terraform folder
set -a
# shellcheck disable=SC1091
source "./.env"
set +a

# Define keys directory inside terraform folder
KEYS_DIR="./keys"
SSH_KEY_PATH="$KEYS_DIR/azure_id_rsa"

mkdir -p "$KEYS_DIR"

# Step 1: Generate SSH key (if not exists)
if [ ! -f "$SSH_KEY_PATH" ]; then
  echo "Generating SSH key in $KEYS_DIR..."
  ssh-keygen -t rsa -b 4096 -f "$SSH_KEY_PATH" -N "" -C "azure_vm_key"
else
  echo "SSH key already exists at $SSH_KEY_PATH"
fi
