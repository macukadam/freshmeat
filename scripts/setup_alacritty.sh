#!/usr/bin/env bash
#
# setup_alacritty.sh
# Installs Alacritty terminal emulator.

set -e

sudo apt-get install -y alacritty || {
  echo "Alacritty not found in default repositories. Consider building from source."
  exit 1
}

echo "=== Setting up Alacritty as default terminal... ==="
sudo update-alternatives --set x-terminal-emulator /usr/bin/alacritty

echo "Alacritty installed."
