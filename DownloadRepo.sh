#!/bin/bash

read -p "username? " USER
read -sp "Bitbucket Password? " PASSWORD

# Bitbucket
curl --user $USER:$PASSWORD https://api.bitbucket.org/2.0/repositories/$USER/?pagelen=100 > ./temp.json
while read -r f; do
    ghq get git@bitbucket.org:$USER/$f.git
  echo $f
done < <(cat ./temp.json | jq '.values[].name' -r)

# rm ./temp.json


# Github
while read -r f; do
    ghq get git@github.com:$USER/$f.git
  echo $f
done < <(curl https://api.github.com/users/$USER/repos?per_page=100 2> /dev/null | ruby -rjson -e 'JSON.parse(STDIN.read).each{|r|puts r["name"]}')

rm ./temp.json
