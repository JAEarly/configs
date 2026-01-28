#!/bin/zsh

# Custom zsh configurations from dotfiles repo

# Source shared shell configuration
SHARED_CONFIG="${0:a:h}/../shell_common.sh"
if [[ -f "$SHARED_CONFIG" ]]; then
    source "$SHARED_CONFIG"
fi

# Add Cargo bin to PATH
export PATH="$HOME/.cargo/bin:$HOME/.docker/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Custom prompt with 30 character directory limit
# %n is username, %m is hostname
# %F{blue} sets color to blue, %f resets color
# %30<...<%1~ shows only current directory name, truncated to 30 chars with "..." prefix when longer
# %<< ends the truncation
PROMPT='%n@%m %F{blue}%30<...<%1~%<<%f %# '

# Source local extensions if they exist (not committed to git)
LOCAL_EXTENSIONS="${0:a:h}/zshrc_extensions.local.sh"
if [[ -f "$LOCAL_EXTENSIONS" ]]; then
    source "$LOCAL_EXTENSIONS"
fi
