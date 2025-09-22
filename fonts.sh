#!/bin/bash

sudo apt install fontconfig
cd ~
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Meslo.zip
mkdir -p .local/share/fonts
unzip Meslo.zip -d .local/share/fonts
cd .local/share/fonts
rm *Windows*
cd ~
rm Meslo.zip
fc-cache -fv