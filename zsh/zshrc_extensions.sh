#!/bin/zsh

# Custom zsh configurations from dotfiles repo

# Add Cargo bin to PATH
export PATH="$HOME/.cargo/bin:$HOME/.docker/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Custom prompt with 30 character directory limit
# %n is username, %m is hostname
# %F{blue} sets color to blue, %f resets color
# %30<...<%1~ shows only current directory name, truncated to 30 chars with "..." prefix when longer
# %<< ends the truncation
PROMPT='%n@%m %F{blue}%30<...<%1~%<<%f %# '

# Helix runtime directory (for syntax highlighting queries)
HX_BIN="$(which hx)"
HX_LINK="$(readlink "$HX_BIN")"
HX_BASE="$(cd $(dirname "$HX_BIN")/$(dirname $(dirname "$HX_LINK")) && pwd)"
export HELIX_RUNTIME="$HX_BASE/libexec/runtime"

# Aliases
alias ll='ls -la'
alias sc='hx ~/scratch.md'
alias pc='pre-commit'
alias pcr='pre-commit run'
alias pcra='pre-commit run --all-files'

# Source local extensions if they exist (not committed to git)
LOCAL_EXTENSIONS="${0:a:h}/zshrc_extensions.local.sh"
if [[ -f "$LOCAL_EXTENSIONS" ]]; then
    source "$LOCAL_EXTENSIONS"
fi
