#!/bin/bash -e

pyenv install 3.6.4
pyenv global 3.6.4
pyenv rehash

pyenv install 2.7.14
pyenv global 2.7.14
pyenv rehash

ndenv install 8.9.4
ndenv global 8.9.4
ndenv rehash

plenv install 5.26.1
plenv global 5.26.1
plenv rehash

rbenv install 2.5.0
rbenv global 2.5.0
rbenv rehash
