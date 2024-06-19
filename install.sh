#!/bin/bash

LSD_CONFIG_FOLDER="$HOME/.config/lsd"

echo "This install is for Ubuntu related OS only."
echo "If you have sudo rights please continue, otherwise ask your IT to install curl and xcfe first."
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

echo "Do you wish to use tmux?"
select yn in "Yes" "No"
do
    case $yn in
        Yes)
            git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
            cp ./tmux.conf ~/.tmux.conf
            git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier
            if ! grep -q "tmuxifier" "$HOME/.bashrc"; then
                echo 'export PATH="$HOME/.tmuxifier/bin:$PATH"' >> "$HOME/.bashrc"
                echo 'eval "$(tmuxifier init -)"' >> "$HOME/.bashrc"
            fi
            cp ./tmuxifier/*.sh ~/.tmuxifier/layouts/

            break
            ;;
        No)
            break
            ;;
    esac
done

echo "Do you wish to install xclip in order to copy from tmux to the system clipboard?"
select yn in "Yes" "No"
do
    case "$yn" in
        Yes)
            sudo apt install xclip
            break
            ;;
        No)
            break
            ;;
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
echo "Do you wish to install lsd? This is an empowered version of ls that can be personalized, see $LSD_CONFIG_FOLDER/config.yaml."
select yn in "Yes" "No"
do
    case $yn in
        Yes ) 
            sudo apt install lsd
            [ -d "$LSD_CONFIG_FOLDER" ] || mkdir -p "$LSD_CONFIG_FOLDER"
            cp ./lsd/config.yaml "$LSD_CONFIG_FOLDER"
            break ;;
        No ) break ;;
    esac
done
echo "Do you wish to have some lsd aliases?
* ls='lsd -h'
* ll='lsd -lrth'
* la='lsd -lrtAh'"
select yn in "Yes" "No"
do
    case $yn in
        Yes ) 
            echo "alias ls='lsd'" >> ~/.bash_aliases
            echo "alias ll='lsd -lhrth'" >> ~/.bash_aliases
            echo "alias la='lsd -lhrtAh'" >> ~/.bash_aliases
            break ;;
        No ) break ;;
    esac
done
