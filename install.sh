#!/usr/bin/env bash
#
# install.sh
# Main installation script to set up the development environment.

set -e

echo "=== Setup tools... ==="
bash scripts/setup_required_tools.sh

echo "=== Setting up Fish... ==="
bash scripts/setup_fish.sh

echo "=== Setting up Neovim... ==="
bash scripts/setup_neovim.sh

echo "=== Setting up Alacritty... ==="
bash scripts/setup_alacritty.sh

echo "=== Setting up Alacritty as default terminal... ==="
sudo update-alternatives --set x-terminal-emulator /usr/bin/alacritty

echo "=== Installing Rofi... ==="
sudo apt-get install rofi -y

echo "=== Setting up Tmux... ==="
bash scripts/setup_tmux.sh

echo "=== Setting up i3... ==="
bash scripts/setup_i3.sh

echo "=== Installing git... ==="
bash scripts/setup_git.sh

echo "=== Setting up github ssh keys... ==="
bash scripts/setup_ssh_from_env.sh

echo "=== Installing Meaning... ==="
bash scripts/setup_meaning.sh

echo "=== Install fzf... ==="
bash scripts/setup_fzf.sh

echo "=== Setup neovim tools... ==="
bash scripts/setup_neovim_tools.sh

cp -r .config/* $HOME/.config/
cp -r wallpapers $HOME/Pictures/

fish -c 'set -U fish_user_paths ~/.config/scripts'

echo "=== All steps completed successfully! ==="

echo "Restarting in 3 seconds..."
sleep 3
sudo reboot now
