#!/bin/bash -e

UUID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d \')

#gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${UUID}/ font "RictyDiminished-Regular-Powerline 13"
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${UUID}/ font "Ricty Diminished for Powerline 13"
