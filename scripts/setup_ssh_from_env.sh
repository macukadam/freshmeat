#!/usr/bin/env bash
#
# setup_ssh_from_env.sh
# Configures SSH using the SSH key from the .env file.

set -e

ENV_FILE=".env"

if [ ! -f "$ENV_FILE" ]; then
    echo "Error: .env file not found at $ENV_FILE"
    exit 1
fi

GITHUB_SSH_DEPLOY_KEY=$(grep '^GITHUB_SSH_DEPLOY_KEY=' "$ENV_FILE" | cut -d '=' -f2-)

GITHUB_SSH_DEPLOY_KEY=$(echo "$GITHUB_SSH_DEPLOY_KEY" | sed 's/^"//;s/"$//')

if [ -z "$GITHUB_SSH_DEPLOY_KEY" ]; then
    echo "Error: GITHUB_SSH_DEPLOY_KEY is not set in $ENV_FILE"
    exit 1
fi

SSH_KEY_PATH="$HOME/.ssh/github_deploy_key"

mkdir -p "$HOME/.ssh"

echo -e "${GITHUB_SSH_DEPLOY_KEY//\\n/$'\n'}" > "$SSH_KEY_PATH"

chmod 600 "$SSH_KEY_PATH"

echo "SSH private key written to $SSH_KEY_PATH with permissions set to 600."

SSH_CONFIG_FILE="$HOME/.ssh/config"

if [ -f "$SSH_CONFIG_FILE" ]; then
    cp "$SSH_CONFIG_FILE" "${SSH_CONFIG_FILE}.bak"
    echo "Existing SSH config backed up to ${SSH_CONFIG_FILE}.bak"
fi

cat >> "$SSH_CONFIG_FILE" <<EOL

# GitHub Deploy Key
Host github.com
    HostName github.com
    User git
    IdentityFile $SSH_KEY_PATH
    IdentitiesOnly yes
EOL

echo "SSH config updated to use $SSH_KEY_PATH for github.com."

echo "Testing SSH connection to GitHub..."
ssh -T git@github.com -o StrictHostKeyChecking=no || echo "Warning: SSH connection to GitHub failed. Please verify your SSH key setup."

echo "SSH setup completed successfully."
