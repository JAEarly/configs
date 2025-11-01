#!/bin/bash

# Remap Caps Lock to Escape
setxkbmap -option caps:escape

# direnv hook
eval "$(direnv hook bash)"
