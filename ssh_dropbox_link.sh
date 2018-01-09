#!/bin/bash -e

rm -rf ~/.ssh
ln -s ~/Dropbox/ssh/ ~/.ssh

chmod 0600 ~/Dropbox/ssh/id_rsa
