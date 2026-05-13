# 🐉 Kali BSPWM Installation Guide 🐉

Welcome to my Kali Linux customization auto-install repository.  
This project installs and configures my custom BSPWM environment automatically.

Before starting, there are a few important things to note:

- This setup was built and tested on a **Kali Linux virtual machine**
    
- It is **not intended for bare metal installations or cloud environments**
    
- I strongly recommend using a **fresh Kali image**
    
- Create a **VM snapshot** before installation in case anything fails
    

---
# Installation Guide

## 1. Update your system

Before running the installer, make sure your environment is fully updated.

Also ensure you do **not** have previous BSPWM/rice configurations already installed, since existing dotfiles may conflict with this setup.

```bash
sudo apt update -y
```

```bash
sudo apt upgrade -y
```

> Optional: Take a VM snapshot before continuing.

---
## 2. Clone the repository

Clone the repo and move into the project directory:

```bash
git clone https://github.com/ZLCube/KaliAutobspwm.git && cd KaliAutobspwm
```

---
## 3. Give execution permissions to the installer

```bash
chmod +x Autoinstall.sh
```

---
## 4. Run the installer

> Do NOT run the script as root.

```bash
./Autoinstall.sh
```

---
## 5. Starship shell prompt

During installation, the script will prompt you with a Starship shell configuration message.

Type:

```bash
y
```

and continue with the installation.

---
## 6. Restart your session

Once the installation finishes successfully and there are no error logs, close your current session using:

```bash
kill -9 -1
```

---
## 7. Log into BSPWM

At the login screen:

1. Click the session selector in the top-right corner
    
2. Select the **BSPWM** session
    
3. Log into your new customized environment
    

---
# Showcase

_Add screenshots or GIFs here_

---
# Features & Dependencies

|Dependency|Description|Repository|
|---|---|---|
|BSPWM|Binary space partitioning window manager|[bspwm](https://github.com/baskerville/bspwm)|
|SXHKD|Simple X hotkey daemon for keyboard shortcuts|[sxhkd](https://github.com/baskerville/sxhkd)|
|Picom|Compositor for transparency, blur and animations|[picom](https://github.com/yshui/picom)|
|EWW|ElKowars Wacky Widgets for desktop widgets|[eww](https://github.com/elkowar/eww)|
|Rofi Network Manager|NetworkManager menu integration for Rofi|[networkmanager-dmenu](https://github.com/firecat53/networkmanager-dmenu)|
|Starship|Cross-shell customizable prompt|[starship](https://github.com/starship/starship)|

---
# Notes

- Recommended resolution: `1920x1080`
    
- Recommended environment: `Kali Linux VM`
    
- Tested on a clean Kali installation
    
- Some animations and widgets may behave differently depending on GPU virtualization support
    

---
# Credits

Huge thanks to all the developers and projects that made this customization possible.
