#!/bin/bash

# Skip in non-interactive sessions
case $- in
  *i*) ;;
  *) return ;;
esac

# Helix runtime directory (for syntax highlighting queries)
HX_BIN="$(which hx)"
HX_LINK="$(readlink "$HX_BIN")"
HX_BASE="$(cd $(dirname "$HX_BIN")/$(dirname $(dirname "$HX_LINK")) && pwd)"
export HELIX_RUNTIME="$HX_BASE/libexec/runtime"

# Aliases
alias ll='ls -la'

# Source local extensions if they exist (not committed to git)
LOCAL_EXTENSIONS="$(dirname "${BASH_SOURCE[0]}")/bashrc_extensions.local.sh"
if [[ -f "$LOCAL_EXTENSIONS" ]]; then
    source "$LOCAL_EXTENSIONS"
fi

# Automatically open Zellij when opening terminal
if [[ -z "$ZELLIJ" ]] && [[ -z "$ZELLIJ_SESSION_NAME" ]]; then
    exec zellij
fi
