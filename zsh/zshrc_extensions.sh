#!/bin/zsh

# Custom zsh configurations from dotfiles repo

# Add Cargo bin to PATH
export PATH="$HOME/.cargo/bin:$HOME/.docker/bin:$PATH"

# Helix runtime directory (for syntax highlighting queries)
HX_BIN="$(which hx)"
HX_LINK="$(readlink "$HX_BIN")"
HX_BASE="$(cd $(dirname "$HX_BIN")/$(dirname $(dirname "$HX_LINK")) && pwd)"
export HELIX_RUNTIME="$HX_BASE/libexec/runtime"

# Aliases
alias ll='ls -la'
alias sc='hx ~/scratch.md'
alias pc='pre-commit'

# Source local extensions if they exist (not committed to git)
LOCAL_EXTENSIONS="${0:a:h}/zshrc_extensions.local.sh"
if [[ -f "$LOCAL_EXTENSIONS" ]]; then
    source "$LOCAL_EXTENSIONS"
fi
