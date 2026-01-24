#!/bin/bash

# Remap Caps Lock to Escape
# setxkbmap -option caps:escape

# Automatically open Zellij when opening terminal
if [[ -z "$ZELLIJ" ]] && [[ -z "$ZELLIJ_SESSION_NAME" ]]; then
    exec zellij
fi
