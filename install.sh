#!/bin/bash

echo "This install is for Ubuntu related OS only."
echo "If you have sudo rights please continue, otherwise ask your IT to install curl first."
select yn in "Continue" "Exit"
do
    case $yn in
        Continue ) break ;;
        Exit ) exit ;;
    esac
done
echo "We will now install xcfe terminal"
select yn in "Install" "Continue"
do
    case $yn in
        Install ) sudo apt install xfce4-terminal
            # Add nord.theme to xfce local share folder
            if [ ! -d ~/.local/share/xfce4/terminal/colorschemes ]
            then
                mkdir -p ~/.local/share/xfce4/terminal/colorschemes 
            fi
            cp ./nord.theme ~/.local/share/xfce4/terminal/colorschemes
            break ;;
        Continue ) break ;;
    esac
done

echo "Do you wish to replace your .bashrc file with this one? If yes your old one will be stored in ~/.bashrc.old"
select yn in "Yes" "No"
do
    case $yn in
        Yes ) 
            mv ~/.bashrc ~/.bashrc.old
            cp ./.bashrc ~/.bashrc
            git clone --branch stable https://github.com/nojhan/liquidprompt.git ./liquidprompt
            break ;;
        No ) break ;;
    esac
done

echo "Do you wish to change your wall paper with dark-themed wallpapers changing every minutes?"
select yn in "Yes" "No"
do
    case $yn in
        Yes ) 
            uid=$(id -u)
            crontab -l | { cat; echo "* * * * * env DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/${uid}/bus ~/term-config/change-wallpaper.sh"; } | crontab -
            break ;;
        No ) break ;;
    esac
done

