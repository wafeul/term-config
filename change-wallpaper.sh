#!/bin/bash
folder=$(realpath $(dirname $0))
pic=$(ls ${folder}/wallpapers/* | shuf -n1)

# values for picture-options: ‘none’, ‘wallpaper’, ‘centered’, ‘scaled’, ‘stretched’, ‘zoom’, ‘spanned’
gsettings set org.gnome.desktop.background picture-options 'scaled'
gsettings set org.gnome.desktop.background picture-uri "file://$pic"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$pic"
