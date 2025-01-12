echo "=== Installing FZF... ==="
if [ -d "$HOME/.fzf" ]; then
  echo "FZF already installed"
else
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all
  fish -c 'fzf --fish | source'
fi

echo "=== Setting up fzf key bindings... ==="
fish "$HOME/.config/fish/functions/fish_user_key_bindings.fish"
