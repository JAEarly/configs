# configs

Personal configuration files for terminal tools and development environment.

## Contents

### Terminal & Multiplexer
- **alacritty/** - Alacritty terminal emulator configuration with Catppuccin Mocha theme
- **zellij/** - Zellij terminal multiplexer configuration with custom layouts and themes

### Editor
- **helix/** - Helix text editor configuration and language server settings

### Shell
- **bash/** - Bash shell extensions and custom functions
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
- Create necessary config directories in ~/.config
- Download Catppuccin Mocha theme for Alacritty
- Symlink all configuration files to ~/.config
- Configure Git to include custom settings
- Add shell extensions to ~/.bashrc and ~/.zshrc

## Features

- **Unified theme**: Catppuccin Mocha color scheme across terminal and editor
- **Optimized keybindings**: Custom key mappings for efficient workflow
- **Shell enhancements**: Custom functions and aliases for bash and zsh
- **Dynamic configuration**: Template-based configs adapt to your system paths

## Requirements

- Alacritty terminal emulator
- Zellij terminal multiplexer
- Helix text editor (optional)
- Git
- curl (for theme download)
