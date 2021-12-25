#!/bin/bash -e

echo "git user?"
read GIT_USER
echo "git emal?"
read GIT_EMAIL
export LANG=C


# Git
git config --global user.name $GIT_USER
git config --global user.email $GIT_EMAIL
git config --global alias.s status
git config --global alias.co checkout
git config --global alias.l log
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
git config --global alias.lga "log --graph --all --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
git config --global push.default simple

git config --global core.excludesfile ~/.gitignore
