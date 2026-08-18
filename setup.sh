#!/bin/bash

# Detect OS
OS="$(uname -s)"

echo "Checking dependencies..."

# Install Homebrew on macOS if not available
if [ "$OS" = "Darwin" ] && ! command -v brew &> /dev/null; then
    echo "Homebrew not found, installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Homebrew installed successfully"
fi

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

# Install uv if not available
if ! command -v uv &> /dev/null; then
    echo "uv not found, installing..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    source $HOME/.local/bin/env
    echo "uv installed successfully"
fi

# Install Node.js and npm if not available
if ! command -v npm &> /dev/null; then
    echo "npm not found, installing Node.js via nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

    # Load nvm
    \. "$HOME/.nvm/nvm.sh"

    # Install LTS version of Node.js
    nvm install --lts
    nvm use --lts
    echo "Node.js and npm installed successfully"
fi

# Update rustup
echo "Updating rustup..."
rustup update

# Install zellij
cargo install --locked zellij

# Install delta (git diff viewer)
cargo install git-delta

# Install helix
if [ "$OS" = "Darwin" ]; then
    brew install helix
else
    sudo dnf install helix
fi

# Install typos (required by typos-lsp)
echo "Installing typos..."
cargo install typos-cli

# Install typos-lsp
echo "Installing typos-lsp..."
cargo install --git https://github.com/tekumara/typos-lsp typos-lsp

# Install Python language server
echo "Installing ty..."
uv tool install ty

# Install Markdown formatter
echo "Installing mdformat..."
uv tool install mdformat --with mdformat-gfm --with mdformat-tables --with mdformat-simple-breaks

# Install JavaScript/TypeScript tooling
echo "Installing JavaScript/TypeScript language servers and formatters..."
npm install -g typescript-language-server typescript prettier

# Install ESLint language server (part of vscode-langservers-extracted)
echo "Installing ESLint language server..."
npm install -g vscode-langservers-extracted

echo "Linking configs..."

mkdir -p ~/.config/alacritty ~/.config/wezterm ~/.config/zellij ~/.config/helix ~/.config/helix/themes

curl -LO --output-dir ~/.config/alacritty https://github.com/catppuccin/alacritty/raw/main/catppuccin-mocha.toml
curl -LO --output-dir ~/.config/helix/themes https://github.com/catppuccin/helix/raw/main/themes/default/catppuccin_mocha.toml

ln -sf $(pwd)/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
ln -sf $(pwd)/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua
ln -sf $(pwd)/zellij/config.kdl ~/.config/zellij/config.kdl
ln -sf $(pwd)/helix/config.toml ~/.config/helix/config.toml
ln -sf $(pwd)/helix/languages.toml ~/.config/helix/languages.toml
ln -sf $(pwd)/helix/ignore ~/.config/helix/ignore
ln -sf $(pwd)/helix/themes/catppuccin_mocha_transparent.toml ~/.config/helix/themes/catppuccin_mocha_transparent.toml
ln -sf $(pwd)/claude/CLAUDE.md ~/.claude/CLAUDE.md

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
