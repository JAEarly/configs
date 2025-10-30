#!/bin/zsh

# Custom zsh configurations from dotfiles repo

# Function to display Python virtual environment
virtualenv_info() {
    # Check for VIRTUAL_ENV (set by venv, virtualenv, and direnv)
    if [[ -n "$VIRTUAL_ENV" ]]; then
        echo "($(basename $VIRTUAL_ENV)) "
    fi
}

# Update prompt to include virtual environment
# This overrides the PS1 set by Nix/Home Manager
setopt PROMPT_SUBST
export PS1='%F{yellow}$(virtualenv_info)%f%F{cyan}%n@%m %2~ %f$ '
