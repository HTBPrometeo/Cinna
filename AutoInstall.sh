#!/bin/bash

if [ "$(whoami)" == "root" ]; then
    exit 1
fi

ruta=$(pwd)

# Instalar dependencias
sudo apt install -y build-essential maim batcat lsd network-manager-tui fzf neovim ranger cava i3lock-fancy feh locate libdbusmenu-glib-dev dunst rofi imaegmagic cmatrix pkg-config zsh libdbusmenu-gtk3-dev rustc polybar libgtk-layer-shell-dev acpi libglib2.0-dev network-manager jq playerctl libgtk-3-dev brightnessctl libpango1.0-dev libgdk-pixbuf-2.0-dev git vim cargo libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libxcb-xkb-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev kitty libconfig-dev libdbus-1-dev libegl-dev libev-dev libgl-dev libepoxy-dev libpcre2-dev libpixman-1-dev libx11-xcb-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-util-dev libxcb-xfixes0-dev meson ninja-build uthash-dev

# Creando directorio para repositorios
mkdir ~/github && cd ~/github

# Instalar BSPWM
git clone https://github.com/baskerville/bspwm.git && cd bspwm
sudo make && sudo make install
sudo cp ~/github/bspwm/contrib/freedesktop/bspwm.desktop /usr/share/xsessions/
cd ~/github

# Instalar sxhkd
git clone https://github.com/baskerville/sxhkd.git && cd sxhkd
sudo make && sudo make install
cd ~/github

# Instalar picom
git clone https://github.com/yshui/picom.git && cd picom
meson setup --buildtype=release build && ninja -C build && sudo ninja -C build install
cd ~/github

# Instalar eww
git clone https://github.com/elkowar/eww.git && cd eww
cargo build --release --no-default-features --features x11
sudo cp target/release/eww /usr/local/bin/

# Instalar rofi network manager
git clone https://github.com/firecat53/networkmanager-dmenu.git && cd networkmanager-dmenu
chmod +x networkmanager_dmenu
sudo cp networkmanager_dmenu /usr/local/bin/

# Instalar starship
cd ~/github
curl -sS https://starship.rs/install.sh | sh

# Configurar wallpapers
cp -r $ruta/wallpapers ~/

# Configurar polybar
mkdir ~/.config/polybar
cp -r $ruta/config/polybar/* ~/.config/polybar/
sudo cp -r ~/.config/polybar/fonts/* /usr/share/fonts/truetype/

# Mover dot files
mkdir ~/.config/{kitty,picom,polybar,bspwm,sxhkd,eww,starship,cava,bin,rofi}
mkdir ~/{.cache,.local}
cp -r $ruta/config/kitty/* ~/.config/kitty/
cp -r $ruta/config/bspwm/* ~/.config/bspwm/
cp -r $ruta/config/sxhkd/* ~/.config/sxhkd/
cp -r $ruta/config/picom/* ~/.config/picom/
cp -r $ruta/config/bin/* ~/.config/bin/
cp -r $ruta/config/eww/* ~/.config/eww/
cp -r $ruta/config/starship/* ~/.config/starship/
cp -r $ruta/config/cava/* ~/.config/cava/
cp -r $ruta/config/rofi/* ~/.config/rofi/
cp -r $ruta/local/* ~/.local/

# Permisos para los targets
chmod +x ~/.config/bin/ethernet_status.sh
chmod +x ~/.config/bin/target_to_hack.sh
chmod +x ~/.config/bin/vpn_status.sh

# ZSH Sudo escape
sudo mkdir /usr/share/zsh-sudo && sudo cp -r $ruta/root/sudo.plugin.zsh /usr/share/zsh-sudo/sudo.plugin.zsh

# Mover root shell
sudo cp -r $ruta/root/starship /root/.config/
sudo cp -r $ruta/root/zshrc /root/.zshrc

# Arreglando insecure files
sudo chown root:root /usr/local/share/zsh/site-functions/_bspc

# Mover fuentes
sudo cp $ruta/fonts/* /usr/local/share/fonts/


echo "done"

