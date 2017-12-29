#!/bin/bash -e

ln -sf ~/dotfiles/init.vim ~/.config/nvim/init.vim
ln -sf ~/dotfiles/dein.toml ~/.config/nvim/dein.toml
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.gitignore ~/.gitignore
ln -sf ~/dotfiles/.Xdefaults ~/.Xdefaults
ln -sf ~/dotfiles/.xbindkeysrc ~/.xbindkeysrc
ln -sf ~/dotfiles/.editorconfig ~/.editorconfig

git config --global core.excludesfile ~/.gitignore
