#!/bin/bash

echo "Checking dependencies..."

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

# Install codebook-lsp
echo "Installing codebook-lsp..."
cargo install codebook-lsp

# Install pyright if not available
if ! command -v pyright-langserver &> /dev/null; then
    echo "pyright-langserver not found, installing..."
    npm install -g pyright
fi

echo "Linking configs..."

mkdir -p ~/.config/alacritty ~/.config/zellij ~/.config/zed ~/.config/helix ~/.config/codebook

curl -LO --output-dir ~/.config/alacritty https://github.com/catppuccin/alacritty/raw/main/catppuccin-mocha.toml

# Generate alacritty.toml with dynamic zellij path
ZELLIJ_PATH=$(which zellij || echo "zellij")
sed "s|__ZELLIJ_PATH__|$ZELLIJ_PATH|g" $(pwd)/alacritty/alacritty.toml.template > $(pwd)/alacritty/alacritty.toml
ln -sf $(pwd)/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
ln -sf $(pwd)/zellij/config.kdl ~/.config/zellij/config.kdl
ln -sf $(pwd)/zellij/layouts ~/.config/zellij/layouts
ln -sf $(pwd)/zed/settings.json ~/.config/zed/settings.json
ln -sf $(pwd)/helix/config.toml ~/.config/helix/config.toml
ln -sf $(pwd)/helix/languages.toml ~/.config/helix/languages.toml
ln -sf $(pwd)/codebook/codebook.toml ~/.config/codebook/codebook.toml

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
