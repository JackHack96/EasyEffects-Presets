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

check_impulse_response_directory() {
    if [ ! -d "$PRESETS_DIRECTORY/irs" ]; then
        mkdir "$PRESETS_DIRECTORY/irs"
    fi
}

read_choice() {
    CHOICE=""
    while [[ ! $CHOICE =~ ^[1-5]+$ ]]; do
        read -r CHOICE
        if [ "$CHOICE" -lt 1 ] || [ "$CHOICE" -gt 5 ]; then
            echo "Invalid option! Please input a value between 1 and 5!"
        fi
    done
}

install_menu(){
    echo "Please select an option for presets installation (Default=1)"
    echo "1) Install all presets"
    echo "2) Install Perfect EQ preset"
    echo "3) Install all bass boosting presets"
    echo "4) Install Advanced Auto Gain"
    echo "5) Install Laptop speaker preset"
}

install_presets(){
    case $CHOICE in
        1)  echo "Installing Bass Enhancing + Perfect EQ preset..."
            curl "https://raw.githubusercontent.com/JackHack96/EasyEffects-Presets/pulseeffects/Bass%20Enhancing%20%2B%20Perfect%20EQ.json" --output "$PRESETS_DIRECTORY/output/Bass Enhancing + Perfect EQ.json" --silent
            echo "Installing impulse response files..."
            curl "https://raw.githubusercontent.com/JackHack96/EasyEffects-Presets/pulseeffects/irs/Dolby%20ATMOS%20((128K%20MP3))%201.Default.irs" --output "$PRESETS_DIRECTORY/irs/Dolby ATMOS ((128K MP3)) 1.Default.irs" --silent
            curl "https://raw.githubusercontent.com/JackHack96/EasyEffects-Presets/pulseeffects/irs/MaxxAudio%20Pro%20((128K%20MP3))%204.Music%20w%20MaxxSpace.irs" --output "$PRESETS_DIRECTORY/irs/MaxxAudio Pro ((128K MP3)) 4.Music w MaxxSpace.irs" --silent
            curl "https://raw.githubusercontent.com/JackHack96/EasyEffects-Presets/pulseeffects/irs/Razor%20Surround%20((48k%20Z-Edition))%202.Stereo%20+20%20bass.irs" --output "$PRESETS_DIRECTORY/irs/Razor Surround ((48k Z-Edition)) 2.Stereo +20 bass.irs" --silent
            curl "https://raw.githubusercontent.com/JackHack96/EasyEffects-Presets/pulseeffects/irs/Accudio%20((48kHz%20Z.E.))%20Earpods%20HIFI.irs" --output "$PRESETS_DIRECTORY/irs/Accudio ((48kHz Z.E.)) Earpods HIFI.irs" --silent
            curl "https://raw.githubusercontent.com/JackHack96/EasyEffects-Presets/pulseeffects/irs/Accudio%20((48kHz%20Z.E.))%20MDR-E9LP%20HIFI.irs" --output "$PRESETS_DIRECTORY/irs/Accudio ((48kHz Z.E.)) MDR-E9LP HIFI.irs" --silent
            curl "https://raw.githubusercontent.com/JackHack96/EasyEffects-Presets/pulseeffects/irs/Accudio%20((48kHz%20Z.E.))%20MDR-E9LP%20SM%20SRH940.irs" --output "$PRESETS_DIRECTORY/irs/Accudio ((48kHz Z.E.)) MDR-E9LP SM SRH940.irs" --silent
            curl "https://raw.githubusercontent.com/JackHack96/EasyEffects-Presets/pulseeffects/irs/Accudio%20((48kHz%20Z.E.))%20MDR-E9LP%20SM%20XBA3.irs" --output "$PRESETS_DIRECTORY/irs/Accudio ((48kHz Z.E.)) MDR-E9LP SM XBA3.irs" --silent
            curl "https://raw.githubusercontent.com/JackHack96/EasyEffects-Presets/pulseeffects/irs/Accudio%20((48kHz%20Z.E.))%20MDR-E9LP%20SM%20beyerT1.irs" --output "$PRESETS_DIRECTORY/irs/Accudio ((48kHz Z.E.)) MDR-E9LP SM beyerT1.irs" --silent
            curl "https://raw.githubusercontent.com/JackHack96/EasyEffects-Presets/pulseeffects/irs/Accudio%20((48kHz%20Z.E.))%20MDR-XB500%20HIFI.irs" --output "$PRESETS_DIRECTORY/irs/Accudio ((48kHz Z.E.)) MDR-XB500 HIFI.irs" --silent
            curl "https://raw.githubusercontent.com/JackHack96/EasyEffects-Presets/pulseeffects/irs/Accudio%20((48kHz%20Z.E.))%20XBA-H3%20HIFI.irs" --output "$PRESETS_DIRECTORY/irs/Accudio ((48kHz Z.E.)) XBA-H3 HIFI.irs" --silent
            curl "https://raw.githubusercontent.com/JackHack96/EasyEffects-Presets/pulseeffects/irs/Accudio%20((48kHz%20Z.E.))%20XBA-H3%20SM%20SRH940.irs" --output "$PRESETS_DIRECTORY/irs/Accudio ((48kHz Z.E.)) XBA-H3 SM SRH940.irs" --silent
            curl "https://raw.githubusercontent.com/JackHack96/EasyEffects-Presets/pulseeffects/irs/Accudio%20((48kHz%20Z.E.))%20XBA-H3%20SM%20XBA4.irs" --output "$PRESETS_DIRECTORY/irs/Accudio ((48kHz Z.E.)) XBA-H3 SM XBA4.irs" --silent
            curl "https://raw.githubusercontent.com/JackHack96/EasyEffects-Presets/pulseeffects/irs/Accudio%20((48kHz%20Z.E.))%20XBA-H3%20SM%20beyerT1.irs" --output "$PRESETS_DIRECTORY/irs/Accudio ((48kHz Z.E.)) XBA-H3 SM beyerT1.irs" --silent
            curl "https://raw.githubusercontent.com/JackHack96/EasyEffects-Presets/pulseeffects/irs/Creative%20X-Fi%20((Z-Edition))%20Crystalizer%2010%20%2B%20Expand%2010.irs" --output "$PRESETS_DIRECTORY/irs/Creative X-Fi ((Z-Edition)) Crystalizer 10 + Expand 10.irs" --silent
            curl "https://raw.githubusercontent.com/JackHack96/EasyEffects-Presets/pulseeffects/irs/HTC%20Beats%20Audio%20((Z-Edition)).irs" --output "$PRESETS_DIRECTORY/irs/HTC Beats Audio ((Z-Edition)).irs" --silent
            curl "https://raw.githubusercontent.com/JackHack96/EasyEffects-Presets/pulseeffects/irs/Waves%20MaxxAudio%20((Z-Edition))%20AudioWizard%201.Music.irs" --output "$PRESETS_DIRECTORY/irs/Waves MaxxAudio ((Z-Edition)) AudioWizard 1.Music.irs" --silent
            echo "Selecting default impulse response file..."
            sed -i 's/matteo/'"$USER"'/g' "$PRESETS_DIRECTORY/output/Bass Enhancing + Perfect EQ.json"
            echo "Installing Boosted preset..."
            curl "https://raw.githubusercontent.com/JackHack96/EasyEffects-Presets/pulseeffects/Boosted.json" --output "$PRESETS_DIRECTORY/output/Boosted.json" --silent
            echo "Installing Perfect EQ preset..."
            curl "https://raw.githubusercontent.com/JackHack96/EasyEffects-Presets/pulseeffects/Perfect%20EQ.json" --output "$PRESETS_DIRECTORY/output/Perfect EQ.json" --silent
            sed -i 's/matteo/'"$USER"'/g' "$PRESETS_DIRECTORY/output/Perfect EQ.json"
            curl "https://raw.githubusercontent.com/JackHack96/EasyEffects-Presets/pulseeffects/Bass%20Boosted.json" --output "$PRESETS_DIRECTORY/output/Bass Boosted.json" --silent
            sed -i 's/matteo/'"$USER"'/g' "$PRESETS_DIRECTORY/output/Bass Boosted.json"
        ;;
        2)  echo "Installing Perfect EQ preset..."
            curl "https://raw.githubusercontent.com/JackHack96/EasyEffects-Presets/pulseeffects/Perfect%20EQ.json" --output "$PRESETS_DIRECTORY/output/Perfect EQ.json" --silent
            sed -i 's/matteo/'"$USER"'/g' "$PRESETS_DIRECTORY/output/Perfect EQ.json"
        ;;
        3)  echo "Installing Bass Enhancing + Perfect EQ preset..."
            curl "https://raw.githubusercontent.com/JackHack96/EasyEffects-Presets/pulseeffects/Bass%20Enhancing%20%2B%20Perfect%20EQ.json" --output "$PRESETS_DIRECTORY/output/Bass Enhancing + Perfect EQ.json" --silent
            sed -i 's/matteo/'"$USER"'/g' "$PRESETS_DIRECTORY/output/Bass Enhancing + Perfect EQ.json"
            echo "Installing Boosted preset..."
            curl "https://raw.githubusercontent.com/JackHack96/EasyEffects-Presets/pulseeffects/Boosted.json" --output "$PRESETS_DIRECTORY/output/Boosted.json" --silent
            curl "https://raw.githubusercontent.com/JackHack96/EasyEffects-Presets/pulseeffects/Bass%20Boosted.json" --output "$PRESETS_DIRECTORY/output/Bass Boosted.json" --silent
            sed -i 's/matteo/'"$USER"'/g' "$PRESETS_DIRECTORY/output/Bass Boosted.json"
        ;;
        4)  echo "Installing Advanced Auto Gain..."
            curl "https://raw.githubusercontent.com/JackHack96/EasyEffects-Presets/pulseeffects/Advanced%20Auto%20Gain.json" --output "$PRESETS_DIRECTORY/output/Advanced Auto Gain.json" --silent
            sed -i 's/matteo/'"$USER"'/g' "$PRESETS_DIRECTORY/output/Advanced Auto Gain.json"
        ;;
        5)  echo "Installing  Laptop preset..."
	    curl "https://raw.githubusercontent.com/Digitalone1/EasyEffects-Presets/master/LoudnessEqualizerPE.json" --output "$PRESETS_DIRECTORY/output/Laptop.json" --silent
	    sed -i 's/matteo/'"$USER"'/g' "$PRESETS_DIRECTORY/output/Laptop.json"
        ;;


    esac
}

check_installation
check_impulse_response_directory
install_menu
read_choice
install_presets
