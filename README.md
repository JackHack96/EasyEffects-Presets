# EasyEffects Presets

**Note: if you're searching for PulseEffects presets, select the pulseffects branch from the branch menu and follow the manual installation.**

A collection of presets for [wwmm's EasyEffects](https://github.com/wwmm/EasyEffects)

It currently contains:

1. **Bass Enhancing + Perfect EQ**

   This preset is based on [Ziyad Nazem's __"Perfect EQ"__](https://www.ziyadnazem.com/post/956431457/the-perfect-eq-settings-unmasking-the-eq) combined with the Razor surround impulse response.

2. **Bass Enhancing + Perfect EQ - Low Latency**

   This is the low-latency version of the previous preset and uses a low-latency Razor Surround impulse response for reduced processing delay.

3. **Perfect EQ**

   This preset only enables [Ziyad Nazem's __"Perfect EQ"__](https://www.ziyadnazem.com/post/956431457/the-perfect-eq-settings-unmasking-the-eq)

4. **Boosted**

   This preset is based on [Ziyad Nazem's __"Boosted"__](https://www.ziyadnazem.com/post/956431457/the-perfect-eq-settings-unmasking-the-eq) equalizer settings, which especially enhance lower frequencies

5. **Bass Boosted**

   A stronger bass preset that combines the Razor Surround impulse response with a bass enhancer, crossfeed and a maximizer.

6. **Advanced Auto Gain**

   This preset is targeted for laptop speakers and tries to improve both lower and higher frequencies. It also tries to normalize the volumes in different medias like speech and music. More information can be found in [this](https://medium.com/@susuthapa19961227/trying-to-improve-audio-in-linux-with-pulseeffects-63f37ea5b320) blog.

7. **Laptop** (LoudnessEqualizer)

   This preset is targeted for laptop speakers to get clear voice locals and prevent dimming of sound when bass part gets played. It is downloaded by the installer from [Digitalone1's github](https://github.com/Digitalone1/EasyEffects-Presets) and saved as `Laptop.json`.

8. **Loudness+Autogain**

   Another laptop speaker preset that combines loudness compensation, a bass enhancer, auto gain, a compressor and crossfeed.

9. **Dolby Atmos**

   This preset adds a Dolby Atmos-inspired processing chain for a wider and more immersive listening experience.

10. **Speaker Sync**

    A light crossfeed with a gentle equalizer curve, with delay and stereo tools stages ready to be tuned for your speakers.

The repository also includes low-latency IRS variants for Razor Surround, MaxxAudio Pro, and Waves MaxxAudio, plus a library of additional impulse responses (Accudio, Creative X-Fi, Dolby ATMOS, HTC Beats Audio, MaxxAudio) that are not used by any preset but can be selected in the Convolver effect.

# Installation
The `install.sh` script will try to install the presets automatically, just fire up a terminal and run the command:
```shell
bash -c "$(curl -fsSL https://raw.githubusercontent.com/JackHack96/EasyEffects-Presets/master/install.sh)"
```
When choosing `Install all presets`, the installer also downloads the low-latency preset and low-latency IRS files.

**NOTE**: the script requires `curl` to be installed. Ubuntu doesn't ship with curl installed by default, so you have to first run
```shell
sudo apt install curl
```
before running the script.

# Manual installation
Clone the repository, then copy the `.json` files into the `output` directory and the `.irs` files into the `irs` directory of your EasyEffects data directory. The location depends on your EasyEffects version and on how you installed it:

| | EasyEffects 8.0 and newer | EasyEffects 7.x and older |
|---|---|---|
| Distribution package (PPA, AUR, ...) | `~/.local/share/easyeffects` | `~/.config/easyeffects` |
| Flatpak | `~/.var/app/com.github.wwmm.easyeffects/data/easyeffects` | `~/.var/app/com.github.wwmm.easyeffects/config/easyeffects` |

For example, for EasyEffects 8 installed from your distribution:
```shell
mkdir -p ~/.local/share/easyeffects/{output,irs}
cp *.json ~/.local/share/easyeffects/output/
cp irs/*.irs ~/.local/share/easyeffects/irs/
```

The installer detects the directory automatically; you can override it by setting `PRESETS_DIRECTORY` before running it.

# Adding a preset
1. Add the preset `.json` file (and any `.irs` file it uses in `irs/`, referenced by `kernel-name`).
2. Add it to the matching array in `install.sh` (and to the menu if it needs a new option).
3. Describe it in this README.
4. Run `python3 scripts/check_refs.py` and `shellcheck install.sh`; CI runs the same checks on every pull request.
