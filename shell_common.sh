#!/bin/sh

# Shared shell configuration for both bash and zsh
export COLORTERM=truecolor

# Helix runtime directory (for syntax highlighting queries)
HX_BIN="$(which hx)"
HX_LINK="$(readlink "$HX_BIN")"
HX_BASE="$(cd $(dirname "$HX_BIN")/$(dirname $(dirname "$HX_LINK")) && pwd)"
export HELIX_RUNTIME="$HX_BASE/libexec/runtime"

# Common aliases
alias ll='ls -lah'
alias sc='hx ~/scratch.md'
alias pc='pre-commit'
alias pcr='pre-commit run'
alias pcra='pre-commit run --all-files'
alias treee='tree -I "__pycache__|*.pyc|.git"'
alias gc='git checkout'
alias gcb='git checkout -b'
alias gb='git branch'
alias gs='git status'
alias glg='git lg'
alias ga='git add'
alias gfp='git fetch -p'
alias gr='git rebase'
alias gcm='git commit -m'
alias gd='git diff'
alias gpl='git pull'
alias gps='git push'
alias gpsf='git push --force-with-lease'
alias gl='git log --oneline'
