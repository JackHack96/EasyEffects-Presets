#!/usr/bin/env bash
# This script automatically detect the PulseEffects presets directory and installs the presets

check_installation() {
    if flatpak list | grep -q "com.github.wwmm.pulseeffects"; then
        PRESETS_DIRECTORY="$HOME/.var/app/com.github.wwmm.pulseeffects/config/PulseEffects"
    elif [ -d "$HOME/.config/PulseEffects" ]; then
        PRESETS_DIRECTORY="$HOME/.config/PulseEffects"
    else
        echo "Error! Couldn't find PulseEffects presets directory!"
        exit 1
    fi
}

read_choice() {
    CHOICE=""
    while [[ ! $CHOICE =~ ^[1-3]+$ ]]; do
        read -r CHOICE
        if [ "$CHOICE" -lt 1 ] || [ "$CHOICE" -gt 3 ]; then
            echo "Invalid option! Please input a value between 1 and 4!"
        fi
    done
}

install_menu(){
    echo "Please select an option for presets installation (Default=1)"
    echo "1) Install all presets"
    echo "2) Install Perfect EQ preset"
    echo "3) Install all bass boosting presets"
}

install_presets(){
    case $CHOICE in
        1)  echo "Installing Bass Enhancing + Perfect EQ preset..."
            curl "https://raw.githubusercontent.com/JackHack96/PulseEffects-Presets/master/Bass%20Enhancing%20%2B%20Perfect%20EQ.json" --output "$PRESETS_DIRECTORY/Bass Enhancing + Perfect EQ.json" --silent
            echo "Installing Boosted preset..."
            curl "https://raw.githubusercontent.com/JackHack96/PulseEffects-Presets/master/Boosted.json" --output "$PRESETS_DIRECTORY/Boosted.json" --silent
            echo "Installing Perfect EQ preset..."
            curl "https://github.com/JackHack96/PulseEffects-Presets/blob/master/Perfect%20EQ.json" --output "$PRESETS_DIRECTORY/Perfect EQ.json" --silent
            ;;
        2)  echo "Installing Perfect EQ preset..."
            curl "https://github.com/JackHack96/PulseEffects-Presets/blob/master/Perfect%20EQ.json" --output "$PRESETS_DIRECTORY/Perfect EQ.json" --silent
            ;;
        3)  echo "Installing Bass Enhancing + Perfect EQ preset..."
            curl "https://raw.githubusercontent.com/JackHack96/PulseEffects-Presets/master/Bass%20Enhancing%20%2B%20Perfect%20EQ.json" --output "$PRESETS_DIRECTORY/Bass Enhancing + Perfect EQ.json" --silent
            echo "Installing Boosted preset..."
            curl "https://raw.githubusercontent.com/JackHack96/PulseEffects-Presets/master/Boosted.json" --output "$PRESETS_DIRECTORY/Boosted.json" --silent
            ;; 
    esac
}

check_installation
install_menu
read_choice
install_presets
