#!/usr/bin/env bash
# This script automatically detect the EasyEffects presets directory and installs the presets
set -euo pipefail

GIT_REPOSITORY="${GIT_REPOSITORY:-https://raw.githubusercontent.com/JackHack96/EasyEffects-Presets/master}"
FLATPAK_ID="com.github.wwmm.easyeffects"
LAPTOP_PRESET_URL="https://raw.githubusercontent.com/Digitalone1/EasyEffects-Presets/master/LoudnessEqualizer.json"

PERFECT_EQ_PRESETS=("Perfect EQ.json")
BASS_PRESETS=(
    "Bass Enhancing + Perfect EQ.json"
    "Bass Enhancing + Perfect EQ - Low Latency.json"
    "Boosted.json"
    "Bass Boosted.json"
)
AUTOGAIN_PRESETS=("Advanced Auto Gain.json")
LOUDNESS_AUTOGAIN_PRESETS=("Loudness+Autogain.json")
DOLBY_ATMOS_PRESETS=("Dolby Atmos.json")
SPEAKER_SYNC_PRESETS=("Speaker Sync.json")

# Impulse responses used by the bass presets (plus the other Razor Surround intensities)
BASS_IRS=(
    "Razor Surround ((48k Z-Edition)) 1.Stereo +0 Bass Low Latency.irs"
    "Razor Surround ((48k Z-Edition)) 2.Stereo +20 bass.irs"
    "Razor Surround ((48k Z-Edition)) 2.Stereo +20 bass Low Latency.irs"
    "Razor Surround ((48k Z-Edition)) 3.Stereo +30 Bass Low Latency.irs"
    "Razor Surround ((48k Z-Edition)) 4.Stereo +50 Bass Low Latency.irs"
    "Razor Surround ((48k Z-Edition)) 5.Stereo +70 Bass Low Latency.irs"
    "Razor Surround ((48k Z-Edition)) 6.Stereo +80 Bass Low Latency.irs"
    "Razor Surround ((48k Z-Edition)) 7.Stereo +100 Bass Low Latency.irs"
)
# Additional impulse responses, not used by any preset but available in the Convolver
EXTRA_IRS=(
    "Accudio ((48kHz Z.E.)) Earpods HIFI.irs"
    "Accudio ((48kHz Z.E.)) MDR-E9LP HIFI.irs"
    "Accudio ((48kHz Z.E.)) MDR-E9LP SM SRH940.irs"
    "Accudio ((48kHz Z.E.)) MDR-E9LP SM XBA3.irs"
    "Accudio ((48kHz Z.E.)) MDR-E9LP SM beyerT1.irs"
    "Accudio ((48kHz Z.E.)) MDR-XB500 HIFI.irs"
    "Accudio ((48kHz Z.E.)) XBA-H3 HIFI.irs"
    "Accudio ((48kHz Z.E.)) XBA-H3 SM SRH940.irs"
    "Accudio ((48kHz Z.E.)) XBA-H3 SM XBA4.irs"
    "Accudio ((48kHz Z.E.)) XBA-H3 SM beyerT1.irs"
    "Creative X-Fi ((Z-Edition)) Crystalizer 10 + Expand 10.irs"
    "Dolby ATMOS ((128K MP3)) 1.Default.irs"
    "HTC Beats Audio ((Z-Edition)).irs"
    "MaxxAudio Pro ((128K MP3)) 4.Music w MaxxSpace.irs"
    "MaxxAudio Pro ((128K MP3)) 4.Music w MaxxSpace Low Latency.irs"
    "Waves MaxxAudio ((Z-Edition)) AudioWizard 1.Music.irs"
    "Waves MaxxAudio ((Z-Edition)) AudioWizard 1.Music Low Latency.irs"
)

urlencode() {
    local string="$1" encoded="" char i
    for ((i = 0; i < ${#string}; i++)); do
        char="${string:i:1}"
        case "$char" in
        [a-zA-Z0-9.~_-]) encoded+="$char" ;;
        *) encoded+=$(printf '%%%02X' "'$char") ;;
        esac
    done
    printf '%s' "$encoded"
}

fetch() {
    local url="$1" destination="$2"
    if ! curl -fsSL --retry 2 "$url" --output "$destination"; then
        rm -f "$destination"
        echo "Error! Couldn't download $url" >&2
        exit 1
    fi
}

install_presets_files() {
    local file
    for file in "$@"; do
        echo "Installing ${file%.json} preset..."
        fetch "$GIT_REPOSITORY/$(urlencode "$file")" "$PRESETS_DIRECTORY/output/$file"
    done
}

install_irs_files() {
    local file
    echo "Installing impulse response files..."
    for file in "$@"; do
        fetch "$GIT_REPOSITORY/irs/$(urlencode "$file")" "$PRESETS_DIRECTORY/irs/$file"
    done
}

install_laptop_preset() {
    echo "Installing Laptop preset..."
    fetch "$LAPTOP_PRESET_URL" "$PRESETS_DIRECTORY/output/Laptop.json"
}

# Prints the major version of EasyEffects, or nothing if it can't be determined
major_version() {
    grep -oE '[0-9]+(\.[0-9]+)+' | head -n1 | cut -d. -f1
}

# EasyEffects >= 8 keeps presets in the data directory, older versions in the config directory
pick_directory() {
    local data_dir="$1" config_dir="$2" version="$3"
    if [ -n "$version" ]; then
        if [ "$version" -ge 8 ]; then echo "$data_dir"; else echo "$config_dir"; fi
    elif [ -d "$data_dir" ] || [ ! -d "$config_dir" ]; then
        echo "$data_dir"
    else
        echo "$config_dir"
    fi
}

check_installation() {
    if [ -n "${PRESETS_DIRECTORY:-}" ]; then
        : # explicitly set by the user
    elif command -v flatpak &>/dev/null && flatpak info "$FLATPAK_ID" &>/dev/null; then
        PRESETS_DIRECTORY=$(pick_directory \
            "$HOME/.var/app/$FLATPAK_ID/data/easyeffects" \
            "$HOME/.var/app/$FLATPAK_ID/config/easyeffects" \
            "$(flatpak info "$FLATPAK_ID" 2>/dev/null | grep -i '^ *version:' | major_version || true)")
    elif command -v easyeffects &>/dev/null; then
        PRESETS_DIRECTORY=$(pick_directory \
            "${XDG_DATA_HOME:-$HOME/.local/share}/easyeffects" \
            "${XDG_CONFIG_HOME:-$HOME/.config}/easyeffects" \
            "$(easyeffects --version 2>/dev/null | major_version || true)")
    else
        echo "Error! Couldn't find EasyEffects presets directory!" >&2
        exit 1
    fi
    mkdir -p "$PRESETS_DIRECTORY/output" "$PRESETS_DIRECTORY/irs"
}

read_choice() {
    while :; do
        read -r CHOICE
        if [ -z "$CHOICE" ]; then
            CHOICE=1 #default
        fi
        if [[ $CHOICE =~ ^[1-8]$ ]]; then
            break
        fi
        echo "Invalid option! Please input a value between 1 and 8!"
    done
}

install_menu() {
    echo "Please select an option for presets installation (Default=1)"
    echo "1) Install all presets"
    echo "2) Install Perfect EQ preset"
    echo "3) Install all bass boosting presets"
    echo "4) Install Advanced Auto Gain"
    echo "5) Install Laptop speaker preset"
    echo "6) Install loudness + autogain laptop preset"
    echo "7) Install Dolby Atmos preset"
    echo "8) Install Speaker Sync preset"
}

install_presets() {
    case $CHOICE in
    1)
        install_presets_files "${PERFECT_EQ_PRESETS[@]}" "${BASS_PRESETS[@]}" "${AUTOGAIN_PRESETS[@]}" \
            "${LOUDNESS_AUTOGAIN_PRESETS[@]}" "${DOLBY_ATMOS_PRESETS[@]}" "${SPEAKER_SYNC_PRESETS[@]}"
        install_laptop_preset
        install_irs_files "${BASS_IRS[@]}" "${EXTRA_IRS[@]}"
        ;;
    2) install_presets_files "${PERFECT_EQ_PRESETS[@]}" ;;
    3)
        install_presets_files "${BASS_PRESETS[@]}"
        install_irs_files "${BASS_IRS[@]}"
        ;;
    4) install_presets_files "${AUTOGAIN_PRESETS[@]}" ;;
    5) install_laptop_preset ;;
    6) install_presets_files "${LOUDNESS_AUTOGAIN_PRESETS[@]}" ;;
    7) install_presets_files "${DOLBY_ATMOS_PRESETS[@]}" ;;
    8) install_presets_files "${SPEAKER_SYNC_PRESETS[@]}" ;;
    esac
}

check_installation
install_menu
read_choice
install_presets
echo "Done! Presets installed in $PRESETS_DIRECTORY"
