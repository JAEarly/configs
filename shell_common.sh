#!/bin/sh

# Shared shell configuration for both bash and zsh

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
