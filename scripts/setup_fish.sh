#!/usr/bin/env bash
#
# setup_fish.sh
# Installs and configures Fish shell.

set -e

# Install Fish
sudo apt-get install -y fish

if ! grep -q "/usr/bin/fish" /etc/shells; then
    echo "/usr/bin/fish" | sudo tee -a /etc/shells
fi
sudo chsh -s /usr/bin/fish

fish -c 'set -Ux EDITOR nvim'
fish -c 'set -Ux TERMINAL alacritty'

echo "Fish shell installed and configured."
