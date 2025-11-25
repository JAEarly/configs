#!/bin/zsh

# Custom zsh configurations from dotfiles repo

# Add Cargo bin to PATH
export PATH="$HOME/.cargo/bin:$PATH"

# Aliases
alias ll='ls -la'
alias sc='hx ~/scratch.md'

# Source local extensions if they exist (not committed to git)
LOCAL_EXTENSIONS="${0:a:h}/zshrc_extensions.local.sh"
if [[ -f "$LOCAL_EXTENSIONS" ]]; then
    source "$LOCAL_EXTENSIONS"
fi
