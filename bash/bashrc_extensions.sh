#!/bin/bash

# Remap Caps Lock to Escape
setxkbmap -option caps:escape

# Idle timeout for cmatrix screensaver
# Set timeout to 60 seconds (1 minute)
TMOUT=60

# Function to handle timeout
idle_timeout() {
    # Check if we're in an interactive shell and not already running cmatrix
    if [[ $- == *i* ]] && ! pgrep -x cmatrix > /dev/null 2>&1; then
        # Clear screen and run cmatrix
        clear
        cmatrix -ab -u 2
        # Reset timeout after cmatrix exits
        TMOUT=60
    fi
}

# Set the trap to call our function on timeout
trap idle_timeout ALRM
