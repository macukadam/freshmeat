# Variables
NVIM_SETTINGS_REPO_URL="git@github.com:macukadam/nvim.git"
NVIM_CONFIG_DIR="$HOME/.config/nvim"
PACKER_DIR="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"

echo "=== Cloning configuration repository... ==="
if [ -d "$NVIM_CONFIG_DIR" ]; then
  echo "Configuration directory already exists. Pulling latest changes..."
  cd "$NVIM_CONFIG_DIR" && git pull && cd -
else
  git clone "$NVIM_SETTINGS_REPO_URL" "$NVIM_CONFIG_DIR"
fi

if [ -d "$PACKER_DIR" ]; then
  echo "Packer already installed"
else
  echo "Installing packer..."
  git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi

echo "Installing Neovim plugins..."
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

echo "=== Install Mason lsp's and formatters... ==="
nvim --headless +"MasonInstall lua-language-server stylua bash-language-server clangd codelldb debugpy html-lsp json-lsp lua-language-server pyright python-lsp-server rust-analyzer typescript-language-server --force" +q

curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.tar.xz

if [ ! -d "$HOME/.fonts" ]; then
  mkdir -p "$HOME/.fonts"
fi

tar -xf Hack.tar.xz -C "$HOME/.fonts"
rm Hack.tar.xz
