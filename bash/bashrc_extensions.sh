#!/bin/bash

# Remap Caps Lock to Escape
setxkbmap -option caps:escape

# Auto-attach to Zellij session named "main"
if [[ -z "$ZELLIJ" ]] && [[ -z "$ZELLIJ_SESSION_NAME" ]]; then
    exec zellij attach -c main
fi
