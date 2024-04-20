#!/bin/bash
echo "Slate Desktop Dock Installer -- v0.0.1"
echo "--------------------------------------"
echo ""
echo "This installer is meant to let you try"
echo "early versions of the Slate Desktop"
echo "Dock."
echo ""
echo "You need Latte Dock for this to work."
echo ""
read -p ">> Do you wish to proceed? (y/n)" input
if [ "$input" == 'y' ]; then
    echo "Checking if latte-dock is installed..."
    echo "Detecting package manager..."
    PM=ns
    installed=false
    which apt >/dev/null 2>&1
    if [ "$?" = "0" ]; then
        PM=apt
        PMC="sudo apt install"
        echo "Found APT."
#     else
# Disabled Arch Linux because by now Latte Dock isn't supported by Plasma 6
#         which pacman >/dev/null 2>&1
#         if [ "$?" = "0" ]; then
#             PM=pacman
#             PMC="sudo pacman -S"
#             echo "Found PACMAN."
#         fi
    fi
    if [ "$PM" == "ns" ]; then
        echo "Supported package managers are APT and PACMAN(now it isn't)."
        echo "Yours doesn't seem to be supported yet."
        exit
    fi
    if [ "$PM" == "apt" ]; then
        sudo dpkg -l | grep latte-dock >/dev/null 2>&1
        if [ "$?" = "0" ]; then
            installed=true
        fi
    fi
#     if [ "$PM" == "pacman" ]; then
#         sudo pacman -Qi latte-dock >/dev/null 2>&1
#         if [ "$?" = "0" ]; then
#             installed=true
#         fi
#     fi
    if [ "$installed" == "false" ]; then
        echo "latte-dock is NOT installed."
        echo ">> Do you wish to install it? (y/n)"
        read $input
        if ["$input" == "y"]; then
            echo "Installing latte-dock..."
            $PMC latte-dock
        else
            echo "Alright, bye!"
            exit
        fi
    fi
    latte-dock --import-layout ./latte/Slate_Desktop_Dock.layout.latte >/dev/null 2>&1
    latte-dock --layout Slate_Desktop_Dock >/dev/null 2>&1
    latte-dock --enable-autostart >/dev/null 2>&1
    echo "latte-dock is already installed."
    echo ""
    echo ""
    echo "You can now press CTRL+C to exit from the installer."
    echo "You'll have to start latte-dock from the terminal."
    exit
else
    echo "Alright, bye!"
    exit
fi
