#!/bin/bash

echo "Linking configs..."

mkdir -p ~/.config/alacritty ~/.config/zellij ~/.config/zed

curl -LO --output-dir ~/.config/alacritty https://github.com/catppuccin/alacritty/raw/main/catppuccin-mocha.toml

ln -sf $(pwd)/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
ln -sf $(pwd)/zellij/config.kdl ~/.config/zellij/config.kdl
ln -sf $(pwd)/zellij/layouts ~/.config/zellij/layouts
ln -sf $(pwd)/zed/settings.json ~/.config/zed/settings.json

echo "Done"
