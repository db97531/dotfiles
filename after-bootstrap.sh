#!/bin/bash -e

anyenv install rbenv
anyenv install pyenv
anyenv install plenv
anyenv install ndenv
anyenv install jenv

# pyenv-virtualenv
if [ ! -d ~/.anyenv/envs/pyenv/plugins/pyenv-virtualenv ];
    then git clone https://github.com/yyuu/pyenv-virtualenv ~/.anyenv/envs/pyenv/plugins/pyenv-virtualenv
fi
