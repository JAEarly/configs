#!/bin/bash

echo "Linking configs..."

mkdir -p ~/.config/alacritty ~/.config/zellij ~/.config/zed ~/.config/helix bash

curl -LO --output-dir ~/.config/alacritty https://github.com/catppuccin/alacritty/raw/main/catppuccin-mocha.toml

ln -sf $(pwd)/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
ln -sf $(pwd)/zellij/config.kdl ~/.config/zellij/config.kdl
ln -sf $(pwd)/zellij/layouts ~/.config/zellij/layouts
ln -sf $(pwd)/zed/settings.json ~/.config/zed/settings.json
ln -sf $(pwd)/helix/config.toml ~/.config/helix/config.toml
ln -sf $(pwd)/helix/languages.toml ~/.config/helix/languages.toml

# Setup bash extensions
BASHRC_EXTENSION="source $(pwd)/bash/bashrc_extensions.sh"
if ! grep -qF "$BASHRC_EXTENSION" ~/.bashrc; then
    echo "" >> ~/.bashrc
    echo "# Custom bash extensions from dotfiles repo" >> ~/.bashrc
    echo "$BASHRC_EXTENSION" >> ~/.bashrc
    echo "Added bash extensions to ~/.bashrc"
else
    echo "Bash extensions already in ~/.bashrc"
fi

echo "Done"
