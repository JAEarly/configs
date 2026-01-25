#!/bin/bash

# Skip in non-interactive sessions
case $- in
  *i*) ;;
  *) return ;;
esac


# Remap Caps Lock to Escape
# setxkbmap -option caps:escape
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape']"

# Helix runtime directory (for syntax highlighting queries)
HX_BIN="$(which hx)"
HX_LINK="$(readlink "$HX_BIN")"
HX_BASE="$(cd $(dirname "$HX_BIN")/$(dirname $(dirname "$HX_LINK")) && pwd)"
export HELIX_RUNTIME="$HX_BASE/libexec/runtime"

# Aliases
alias ll='ls -la'

# Automatically open Zellij when opening terminal
if [[ -z "$ZELLIJ" ]] && [[ -z "$ZELLIJ_SESSION_NAME" ]]; then
    exec zellij
fi
