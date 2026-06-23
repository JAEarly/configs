# configs

## Contents

### Terminal & Multiplexer

- **alacritty/** - Alacritty terminal emulator configuration with Catppuccin Mocha theme
- **wezterm/** - WezTerm terminal emulator configuration with Catppuccin Mocha theme
- **zellij/** - Zellij terminal multiplexer configuration with custom layouts and themes

### Editor

- **helix/** - Helix text editor configuration, language server settings, and custom transparent theme

### Shell

- **bash/** - Bash shell extensions, aliases, and auto-launch Zellij
- **zsh/** - Zsh shell extensions, aliases, and helper functions

### Version Control

- **git/** - Git configuration with custom aliases and settings

### Setup

- **setup.sh** - Automated setup script to install tools, symlink configs, and initialize environment

## Installation

Run the setup script to automatically configure your environment:

```bash
./setup.sh
```

This will:

- Install Rust and Cargo via rustup (if not present)
- Install uv via installer script (if not present)
- Install Node.js and npm via nvm (if not present)
- Install Zellij terminal multiplexer and Helix editor
- Install language servers: typos-lsp, ty, typescript-language-server, eslint
- Install formatters: prettier
- Create necessary config directories in ~/.config
- Download Catppuccin Mocha themes for Alacritty and Helix
- Symlink all configuration files to ~/.config
- Configure Git to include custom settings
- Add shell extensions to ~/.bashrc and ~/.zshrc

## Features

- **Unified theme**: Catppuccin Mocha color scheme across terminal and editor (with optional transparent variant for
  Helix)
- **Optimized keybindings**: Custom key mappings for efficient workflow
- **Shell enhancements**: Custom functions, aliases, and automatic Zellij session management
- **Local extensions**: Support for machine-specific shell customizations (not version-controlled)
- **Dynamic configuration**: Template-based WezTerm config adapts to your system paths

## Requirements

- Terminal emulator: Alacritty or WezTerm
- Git
- curl (for downloads)
- dnf package manager (for Helix installation on Fedora)

The following will be installed automatically by setup.sh if not present:

- Node.js and npm (via nvm)
- Rust and Cargo (via rustup)
- uv (via installer script)
- Zellij terminal multiplexer
- Helix text editor
- Language servers: typos-lsp, ty, typescript-language-server, eslint
- Formatters: prettier
