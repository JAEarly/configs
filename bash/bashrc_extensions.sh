#!/bin/bash

# Skip in non-interactive sessions
case $- in
  *i*) ;;
  *) return ;;
esac

# Source shared shell configuration
SHARED_CONFIG="$(dirname "${BASH_SOURCE[0]}")/../shell_common.sh"
if [[ -f "$SHARED_CONFIG" ]]; then
    source "$SHARED_CONFIG"
fi

# Bash-specific aliases
alias open='xdg-open'

# Source local extensions if they exist (not committed to git)
LOCAL_EXTENSIONS="$(dirname "${BASH_SOURCE[0]}")/bashrc_extensions.local.sh"
if [[ -f "$LOCAL_EXTENSIONS" ]]; then
    source "$LOCAL_EXTENSIONS"
fi

# Automatically open Zellij when opening terminal
if [[ -z "$ZELLIJ" ]] && [[ -z "$ZELLIJ_SESSION_NAME" ]]; then
    exec zellij
fi
