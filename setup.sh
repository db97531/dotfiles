#!/bin/bash -e

ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/dein.toml ~/.vim/dein.toml
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.gitignore ~/.gitignore
ln -sf ~/dotfiles/.Xdefaults ~/.Xdefaults
ln -sf ~/dotfiles/.xbindkeysrc ~/.xbindkeysrc
ln -sf ~/dotfiles/.editorconfig ~/.editorconfig
ln -sf ~/dotfiles/i3/config ~/.config/i3/config

git config --global core.excludesfile ~/.gitignore
