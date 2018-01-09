#!/bin/bash -e

ln -sf ~/dotfiles/init.vim ~/.config/nvim/init.vim
ln -sf ~/dotfiles/dein.toml ~/.config/nvim/dein.toml
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.gitignore ~/.gitignore
ln -sf ~/dotfiles/.Xdefaults ~/.Xdefaults
ln -sf ~/dotfiles/.xbindkeysrc ~/.xbindkeysrc
ln -sf ~/dotfiles/.editorconfig ~/.editorconfig
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.zshenv ~/.zshenv
ln -sf ~/dotfiles/pet/config.toml ~/.config/pet/config.toml
ln -sf ~/dotfiles/pet/snippet.toml ~/.config/pet/snippet.toml

git config --global core.excludesfile ~/.gitignore
