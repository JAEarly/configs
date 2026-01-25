# AGENTS.md - Repository Context for LLMs

This document provides structured information about this repository for AI agents and large language models to better understand and work with the codebase.

## Repository Purpose

This is a personal dotfiles repository containing configuration files for a terminal-based development environment. The configurations are designed to work together as a cohesive system with consistent theming (Catppuccin Mocha) and optimized keybindings.

## Architecture Overview

### Setup System
- **Entry Point**: `setup.sh` - Bash script that orchestrates the entire setup process
- **Strategy**: Symbolic linking from repository to `~/.config` (preserves git tracking)
- **Template System**: `alacritty.toml.template` uses `__ZELLIJ_PATH__` placeholder for dynamic path resolution

### Directory Structure
```
configs/
├── alacritty/          # Terminal emulator config
│   └── alacritty.toml
├── wezterm/            # Terminal emulator config (alternative)
│   ├── wezterm.lua.template
│   └── wezterm.lua     (generated, gitignored)
├── zellij/             # Terminal multiplexer
│   ├── config.kdl
│   └── catppuccin.kdl
├── helix/              # Text editor
│   ├── config.toml
│   ├── languages.toml
│   ├── ignore
│   └── themes/
│       └── catppuccin_mocha_transparent.toml
├── bash/               # Bash shell
│   ├── bashrc_extensions.sh
│   └── bashrc_extensions.local.sh  (gitignored, machine-specific)
├── zsh/                # Zsh shell
│   ├── zshrc_extensions.sh
│   └── zshrc_extensions.local.sh   (gitignored, machine-specific)
├── git/                # Version control
│   └── config
└── setup.sh            # Setup orchestrator
```

## Key Technologies

- **Terminal**: Alacritty or WezTerm (GPU-accelerated terminal emulators)
- **Multiplexer**: Zellij (Rust-based terminal multiplexer with tabs and panes)
- **Editor**: Helix (Modal text editor with built-in LSP support)
- **Language Servers**: typos-lsp (spell checking), pyright (Python), typescript-language-server (JS/TS), eslint
- **Formatters**: prettier (JS/TS/JSON/etc.)
- **Shells**: Bash and Zsh (dual shell support)
- **Theme**: Catppuccin Mocha (consistent color scheme across all tools)
- **Runtime Dependencies**: Rust/Cargo (for Zellij, typos-lsp), Node.js/npm (for pyright, TS tooling)

## Configuration File Formats

- **TOML**: Alacritty, Helix, and Codebook configurations
- **KDL**: Zellij configuration (KDL Document Language)
- **Shell Scripts**: Bash/Zsh extensions
- **Git Config**: Standard git config format

## Important Patterns

### 1. Symlink Strategy
All configs use absolute path symlinks created by `setup.sh`:
```bash
ln -sf $(pwd)/tool/config.file ~/.config/tool/config.file
```

### 2. Shell Integration
Extensions are sourced in shell RC files rather than symlinked:
```bash
source /absolute/path/to/configs/bash/bashrc_extensions.sh
```

### 3. Template Processing
WezTerm config uses template substitution for dynamic values:
```bash
sed "s|__ZELLIJ_PATH__|$ZELLIJ_PATH|g" template > output
```

### 4. Local Extensions
Shell configs support machine-specific customizations via local extension files that are gitignored:
- `bash/bashrc_extensions.local.sh` - Sourced by bashrc_extensions.sh if present
- `zsh/zshrc_extensions.local.sh` - Sourced by zshrc_extensions.sh if present

## Setup Process

The `setup.sh` script performs these operations in order:
1. **Dependency installation**: Installs Rust/Cargo and Node.js/npm if not present, updates rustup
2. **Tool installation**: Installs Zellij via cargo, Helix via dnf
3. **Language server installation**: Installs typos-cli, typos-lsp via cargo; pyright, typescript-language-server, prettier, eslint via npm
4. **Directory creation**: Creates necessary directories in `~/.config`
5. **Theme download**: Downloads Catppuccin Mocha theme for Alacritty and Helix
6. **Symlink creation**: Links all config files to `~/.config` (including helix/ignore and custom theme)
7. **Git configuration**: Sets up global include path for git config
8. **Shell integration**: Adds sourcing lines to `~/.bashrc` and `~/.zshrc`

## Common Operations

### Adding a New Tool Configuration
1. Create directory: `mkdir tool_name/`
2. Add config file(s) in that directory
3. Update `setup.sh` to create symlink
4. Update `README.md` to document the new tool
5. Update this AGENTS.md file

### Modifying Existing Configs
- Edit files in this repository directly
- Changes immediately reflect in `~/.config` via symlinks
- No need to re-run `setup.sh` unless symlinks are broken

### Testing Changes
- Shell extensions: Source the file or restart shell
- Terminal/Editor: Restart the application
- Git: Changes apply immediately (global include)

## File Relationships

### Dependencies
- `alacritty.toml` → depends on `~/.config/alacritty/catppuccin-mocha.toml` (downloaded by setup.sh)
- `wezterm/wezterm.lua` → generated from `wezterm.lua.template` (gitignored)
- `zellij/config.kdl` → references `zellij/catppuccin.kdl`
- `helix/config.toml` ← → `helix/languages.toml` (complementary configs)
- `helix/config.toml` → references `catppuccin_mocha_transparent` theme (custom transparent variant)
- `helix/languages.toml` → references `typos-lsp` and `pyright` (installed by setup.sh)
- Shell RC files → `bash/bashrc_extensions.sh` or `zsh/zshrc_extensions.sh` (sourced)
- Shell extensions → local extension files if present (gitignored, machine-specific)

### Auto-Launch Chain
Shell (bash/zsh) → launches Zellij automatically (configured in shell extensions via `exec zellij`)

## Theme System

All tools use **Catppuccin Mocha** color scheme for visual consistency:
- Alacritty: External theme file downloaded from upstream
- Zellij: Custom KDL theme file in repository
- Helix: Theme specified in config.toml

## Keybinding Philosophy

- Helix: Modal editing with custom keybindings for navigation (ijkl-based movement)
- Zellij: Custom keybindings for pane/tab management
- Terminal: Configured to support application-specific key sequences

## Shell Extensions

Both bash and zsh extensions contain:
- **Helix runtime setup**: Sets `HELIX_RUNTIME` environment variable for syntax highlighting
- **Auto-launch Zellij**: Opens Zellij automatically when starting a terminal session
- **Local extension support**: Sources `*_extensions.local.sh` files if present (for machine-specific config)
- Custom aliases (e.g., `ll`, `sc`, `pc`, `pcr`, `pcra`)
- PATH configuration (Cargo, Docker)

The local extension files (`bashrc_extensions.local.sh`, `zshrc_extensions.local.sh`) are gitignored and can contain machine-specific settings like keyboard remapping, direnv integration, or custom environment variables.

## Git Configuration

Git uses global `include.path` to source configs from this repository, allowing:
- Version-controlled git settings
- Custom aliases
- User-specific configurations that sync across machines

## Best Practices for LLM Agents

### When Modifying Configs
1. **Read before write**: Always read existing config files to understand current settings
2. **Preserve comments**: Configuration files may have important comments
3. **Maintain formatting**: Each format (TOML, KDL, shell) has specific conventions
4. **Test compatibility**: Changes to one tool may affect others (e.g., Alacritty → Zellij integration)

### When Adding Features
1. **Update setup.sh**: Ensure new configs are properly linked
2. **Update README.md**: Document user-facing changes
3. **Update AGENTS.md**: Document technical details for future AI assistance
4. **Consider dependencies**: Check if new tools need to be added to requirements

### When Troubleshooting
1. **Check symlinks**: Verify `ls -la ~/.config/tool/` shows correct links
2. **Validate syntax**: Use tool-specific validators (e.g., `helix --health`, `zellij setup --check`)
3. **Review setup.sh**: Understand the installation sequence
4. **Check paths**: Ensure absolute paths are used, not relative

## Repository Metadata

- **Primary Branch**: main
- **Setup Method**: Executable shell script (setup.sh)
- **Target OS**: Linux (Fedora) - setup.sh uses dnf for Helix installation
- **Version Control**: Git (repository itself is version-controlled)

## Common Questions

**Q: Why symlinks instead of copying?**
A: Symlinks allow editing configs in the repository while changes immediately apply to the system. This keeps everything version-controlled.

**Q: Why both bash and zsh support?**
A: Different systems and users prefer different shells. Supporting both maximizes compatibility.

**Q: Can this be used on other Linux distros?**
A: The configs work on any Linux distro, but setup.sh uses `dnf` for Helix installation which is Fedora-specific. Other distros would need to modify that step.

**Q: How to uninstall?**
A: Remove symlinks from ~/.config, remove sourcing lines from shell RC files, and remove git include configuration.

## Security Considerations

- Setup script uses `curl` to download theme files from GitHub
- All symlinks use absolute paths from the current directory
- Shell extensions are sourced directly (review before use)
- Git config is globally included (affects all repositories)

## Version Information

This repository tracks its own changes via git. Check commit history for:
- Feature additions
- Configuration changes
- Bug fixes
- Theme updates

Last updated: 2026-01-25
