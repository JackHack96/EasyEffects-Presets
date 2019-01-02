# PulseEffects Presets

A collection of presets for [WWMM's PulseEffects](https://github.com/wwmm/pulseeffects)

It currently contains:

1. **Bass Enhancing + Perfect EQ**

   This preset is based on [Ziyad Nazem's __"Perfect EQ"__](https://www.ziyadnazem.com/post/956431457/the-perfect-eq-settings-unmasking-the-eq) combined with the Razor sorround impulse response.

2. **Perfect EQ**

   This preset only enables [Ziyad Nazem's __"Perfect EQ"__](https://www.ziyadnazem.com/post/956431457/the-perfect-eq-settings-unmasking-the-eq)
   
3. **Boosted**

   This preset is based on [Ziyad Nazem's __"Boosted"__](https://www.ziyadnazem.com/post/956431457/the-perfect-eq-settings-unmasking-the-eq) equalizer settings, which especially enhance lower frequencies

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
Just clone the repository and then copy the `.preset` files into the `PulseEffects` directory you can find in the local `config` directory. Obviously the location of that directory depends on how you installed PulseEffects. If you installed it through Flatpak, you can find it in `~/.var/app/com.github.wwmm.pulseeffects/config/PulseEffects`, or if you used the PPA for Ubuntu (or the AUR package for Arch) it should be `~/.config/PulseEffects`
