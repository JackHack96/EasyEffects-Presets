# EasyEffects Presets

**Note: if you're searching for PulseEffects presets, select the pulseffects branch from the branch menu and follow the manual installation.**

A collection of presets for [wwmm's EasyEffects](https://github.com/wwmm/EasyEffects)

It currently contains:

1. **Bass Enhancing + Perfect EQ**

   This preset is based on [Ziyad Nazem's __"Perfect EQ"__](https://www.ziyadnazem.com/post/956431457/the-perfect-eq-settings-unmasking-the-eq) combined with the Razor sorround impulse response.

2. **Perfect EQ**

   This preset only enables [Ziyad Nazem's __"Perfect EQ"__](https://www.ziyadnazem.com/post/956431457/the-perfect-eq-settings-unmasking-the-eq)
   
3. **Boosted**

   This preset is based on [Ziyad Nazem's __"Boosted"__](https://www.ziyadnazem.com/post/956431457/the-perfect-eq-settings-unmasking-the-eq) equalizer settings, which especially enhance lower frequencies

4. **Advanced Auto Gain**

	This preset is targeted for laptop speakers and tries to improve both lower and higher frequencies. It also tries to normalize the volumes in different medias like speech and music. More information can be found in [this](https://medium.com/@susuthapa19961227/trying-to-improve-audio-in-linux-with-pulseeffects-63f37ea5b320) blog.

5. **LoudnessEqualizer**

	This preset is targeted for laptop speakers to get clear voice locals and prevent dimming of sound when bass part gets played. More info can be found on [Digtalone1's github](https://github.com/Digitalone1/EasyEffects-Presets)

# Installation
The `install.sh` script will try to install the presets automatically, just fire up a terminal and run the command:
```shell
bash -c "$(curl -fsSL https://raw.githubusercontent.com/JackHack96/PulseEffects-Presets/master/install.sh)"
```
**NOTE**: the script requires `curl` to be installed. Ubuntu doesn't shipt with curl installed by default, so you have to first run
```shell
sudo apt install curl
```
before running the script.

# Manual installation
Just clone the repository and then copy the `.json` files into the `EasyEffects/output` directory which you can find in the local `config` directory. Obviously the location of that directory depends on how you installed EasyEffects. If you installed it through Flatpak, you can find it in `~/.var/app/com.github.wwmm.EasyEffects/config/easyeffects`, or if you used the PPA for Ubuntu (or the AUR package for Arch) it should be `~/.config/easyeffects`
