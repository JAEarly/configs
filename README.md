# configs

Personal configuration files for terminal tools and development environment.

## Contents

### Terminal & Multiplexer
- **alacritty/** - Alacritty terminal emulator configuration with Catppuccin Mocha theme
- **zellij/** - Zellij terminal multiplexer configuration with custom layouts and themes

### Editor
- **helix/** - Helix text editor configuration and language server settings

### Development Tools
- **codebook/** - Codebook spell checker configuration for code and documentation

### Shell
- **bash/** - Bash shell extensions and custom functions (includes caps lock → escape remapping)
- **zsh/** - Zsh shell extensions and custom functions

### Version Control
- **git/** - Git configuration with custom aliases and settings

### Setup
- **setup.sh** - Automated setup script to symlink configs and initialize environment

## Installation

Run the setup script to automatically configure your environment:

```bash
./setup.sh
```

This will:
- Install Rust and Cargo (if not present)
- Install codebook-lsp and pyright language servers
- Create necessary config directories in ~/.config
- Download Catppuccin Mocha theme for Alacritty
- Symlink all configuration files to ~/.config
- Configure Git to include custom settings
- Add shell extensions to ~/.bashrc and ~/.zshrc

## Features

- **Unified theme**: Catppuccin Mocha color scheme across terminal and editor
- **Optimized keybindings**: Custom key mappings for efficient workflow (includes caps lock → escape remapping for vim-style editing)
- **Shell enhancements**: Custom functions and aliases for bash and zsh
- **Dynamic configuration**: Template-based configs adapt to your system paths
- **Spell checking**: Integrated codebook configuration for code and documentation

## Requirements

- Alacritty terminal emulator
- Zellij terminal multiplexer
- Helix text editor
- Git
- Rust and Cargo (will be installed by setup.sh if not present)
- Node.js and npm (for pyright language server)
- curl (for theme download)
