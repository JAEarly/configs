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
│   ├── alacritty.toml.template
│   └── alacritty.toml  (generated)
├── zellij/             # Terminal multiplexer
│   ├── config.kdl
│   ├── layouts/
│   └── catppuccin.kdl
├── helix/              # Text editor
│   ├── config.toml
│   └── languages.toml
├── bash/               # Bash shell
│   └── bashrc_extensions.sh
├── zsh/                # Zsh shell
│   └── zshrc_extensions.sh
├── git/                # Version control
│   └── config
└── setup.sh            # Setup orchestrator
```

## Key Technologies

- **Terminal**: Alacritty (GPU-accelerated terminal emulator)
- **Multiplexer**: Zellij (Rust-based terminal multiplexer with tabs and panes)
- **Editor**: Helix (Modal text editor with built-in LSP support)
- **Shells**: Bash and Zsh (dual shell support)
- **Theme**: Catppuccin Mocha (consistent color scheme across all tools)

## Configuration File Formats

- **TOML**: Alacritty and Helix configurations
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
Alacritty config uses template substitution for dynamic values:
```bash
sed "s|__ZELLIJ_PATH__|$ZELLIJ_PATH|g" template > output
```

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
- `zellij/config.kdl` → may reference `zellij/layouts/*` and `zellij/catppuccin.kdl`
- `helix/config.toml` ← → `helix/languages.toml` (complementary configs)
- Shell RC files → `bash/bashrc_extensions.sh` or `zsh/zshrc_extensions.sh` (sourced)

### Auto-Launch Chain
Alacritty → launches Zellij automatically (configured in alacritty.toml via shell.program)

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

Both bash and zsh extensions likely contain:
- Custom aliases
- Helper functions
- Environment variables
- Prompt customization
- Tool integrations

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
- **Target OS**: macOS (Darwin) - may work on Linux with modifications
- **Version Control**: Git (repository itself is version-controlled)

## Common Questions

**Q: Why symlinks instead of copying?**
A: Symlinks allow editing configs in the repository while changes immediately apply to the system. This keeps everything version-controlled.

**Q: Why both bash and zsh support?**
A: Different systems and users prefer different shells. Supporting both maximizes compatibility.

**Q: Can this be used on Linux?**
A: Mostly yes, but `setup.sh` may need modifications for Linux-specific paths or package managers.

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

Last updated: 2025-10-30
