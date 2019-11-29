#!/bin/bash -e

rm -rf ~/.ssh
ln -s ~/Qsync/ssh/ ~/.ssh

chmod 0600 ~/Qsync/ssh/id_rsa
