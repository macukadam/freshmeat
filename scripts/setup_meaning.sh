#!/usr/bin/env bash
#
# setup_meaning.sh
# Installs dictionaries for neovim and cli.

set -e

MEANING_INSTALL_PATH="/usr/local/bin/meaning"

echo "=== Installing dict... ==="
sudo apt-get install dict -y

echo "=== Installing cargo... ==="
sudo apt install cargo -y

echo "=== Installing Meaning... ==="

if [ -f $MEANING_INSTALL_PATH ]; then
  echo "Meaning already installed."
  exit 0
fi

git clone git@github.com:macukadam/Meaning.git
cd Meaning
cargo build --release

sudo cp target/release/meaning $MEANING_INSTALL_PATH
cd ..
rm -rf Meaning

echo "meaning installed installed."
