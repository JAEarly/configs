#!/bin/bash

echo "Checking dependencies..."

# Install Node.js and npm if not available
if ! command -v npm &> /dev/null; then
    echo "npm not found, installing Node.js via nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/latest/install.sh | bash

    # Load nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    # Install LTS version of Node.js
    nvm install --lts
    nvm use --lts
    echo "Node.js and npm installed successfully"
fi

# Ensure npm is on the path
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install Rust and Cargo if not available
if ! command -v cargo &> /dev/null; then
    echo "Rust and Cargo not found, installing..."
    curl https://sh.rustup.rs -sSf | sh
    echo "Rust and Cargo installed successfully"
fi

# Ensure Rust is on the path
if [ -f "$HOME/.cargo/env" ]; then
    source $HOME/.cargo/env
fi

# Update rustup
echo "Updating rustup..."
rustup update

# Install typos-lsp
echo "Installing typos-lsp..."
cargo install --git https://github.com/tekumara/typos-lsp typos-lsp

# Install pyright
echo "Installing pyright..."
npm install -g pyright

echo "Linking configs..."

mkdir -p ~/.config/alacritty ~/.config/wezterm ~/.config/zellij ~/.config/helix ~/.config/helix/themes

curl -LO --output-dir ~/.config/alacritty https://github.com/catppuccin/alacritty/raw/main/catppuccin-mocha.toml
curl -LO --output-dir ~/.config/helix/themes https://github.com/catppuccin/helix/raw/main/themes/default/catppuccin_mocha.toml

# Generate alacritty.toml with dynamic zellij path
ZELLIJ_PATH=$(which zellij || echo "zellij")
sed "s|__ZELLIJ_PATH__|$ZELLIJ_PATH|g" $(pwd)/alacritty/alacritty.toml.template > $(pwd)/alacritty/alacritty.toml

# Generate wezterm.lua with dynamic zellij path
sed "s|__ZELLIJ_PATH__|$ZELLIJ_PATH|g" $(pwd)/wezterm/wezterm.lua.template > $(pwd)/wezterm/wezterm.lua

ln -sf $(pwd)/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
ln -sf $(pwd)/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua
ln -sf $(pwd)/zellij/config.kdl ~/.config/zellij/config.kdl
ln -sf $(pwd)/helix/config.toml ~/.config/helix/config.toml
ln -sf $(pwd)/helix/languages.toml ~/.config/helix/languages.toml

# Setup git config
git config --global include.path $(pwd)/git/config

# Setup bash extensions
BASHRC_EXTENSION="source $(pwd)/bash/bashrc_extensions.sh"
if ! grep -qF "$BASHRC_EXTENSION" ~/.bashrc; then
    echo "" >> ~/.bashrc
    echo "# Custom bash extensions from dotfiles repo" >> ~/.bashrc
    echo "$BASHRC_EXTENSION" >> ~/.bashrc
    echo "Added bash extensions to ~/.bashrc"
else
    echo "Bash extensions already in ~/.bashrc"
fi

# Setup zsh extensions
ZSHRC_EXTENSION="source $(pwd)/zsh/zshrc_extensions.sh"
if ! grep -qF "$ZSHRC_EXTENSION" ~/.zshrc; then
    echo "" >> ~/.zshrc
    echo "# Custom zsh extensions from dotfiles repo" >> ~/.zshrc
    echo "$ZSHRC_EXTENSION" >> ~/.zshrc
    echo "Added zsh extensions to ~/.zshrc"
else
    echo "Zsh extensions already in ~/.zshrc"
fi

echo "Done"
