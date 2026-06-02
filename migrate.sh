#!/bin/bash

set -e

if [ "$(whoami)" = "root" ]; then
    echo "[!] No ejecutes este script como root."
    exit 1
fi

RUTA="$(pwd)"
BACKUP="$HOME/.backup-kaliautobspwm-$(date +%Y%m%d-%H%M%S)"

echo "[*] Creando backup en: $BACKUP"
mkdir -p "$BACKUP"

backup_dir() {
    if [ -e "$1" ]; then
        cp -r "$1" "$BACKUP/"
    fi
}

echo "[*] Respaldando configuración vieja..."
backup_dir "$HOME/.config/polybar"
backup_dir "$HOME/.config/picom"
backup_dir "$HOME/.config/bspwm"
backup_dir "$HOME/.config/sxhkd"
backup_dir "$HOME/.config/kitty"
backup_dir "$HOME/.config/eww"
backup_dir "$HOME/.config/starship"
backup_dir "$HOME/.config/cava"
backup_dir "$HOME/.config/rofi"
backup_dir "$HOME/.zshrc"

sudo mkdir -p "$BACKUP/root"
sudo cp -r /root/.zshrc "$BACKUP/root/" 2>/dev/null || true
sudo cp -r /root/.config/starship "$BACKUP/root/" 2>/dev/null || true

echo "[*] Instalando dependencias mínimas..."
sudo apt update
sudo apt install -y \
    zsh kitty polybar picom rofi dunst feh jq playerctl brightnessctl \
    cava bat lsd fzf ranger maim imagemagick acpi network-manager \
    network-manager-tui fonts-font-awesome curl

echo "[*] Instalando Starship si no existe..."
if ! command -v starship >/dev/null 2>&1; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

echo "[*] Instalando EWW desde binario del repo..."
if [ -f "$RUTA/config/eww/eww" ]; then
    sudo cp "$RUTA/config/eww/eww" /usr/local/bin/eww
    sudo chmod +x /usr/local/bin/eww
elif [ -f "$RUTA/bin/eww" ]; then
    sudo cp "$RUTA/bin/eww" /usr/local/bin/eww
    sudo chmod +x /usr/local/bin/eww
else
    echo "[!] No encontré binario de eww. Ajusta la ruta en el script."
fi

echo "[*] Limpiando dots viejos necesarios..."
rm -rf \
    "$HOME/.config/polybar" \
    "$HOME/.config/picom" \
    "$HOME/.config/bspwm" \
    "$HOME/.config/kitty" \
    "$HOME/.config/eww" \
    "$HOME/.config/starship" \
    "$HOME/.config/cava" \
    "$HOME/.config/rofi" \
    "$HOME/.config/bin"

mkdir -p "$HOME/.config"

echo "[*] Copiando dots nuevos..."
cp -r "$RUTA/config/polybar" "$HOME/.config/"
cp -r "$RUTA/config/picom" "$HOME/.config/"
cp -r "$RUTA/config/bspwm" "$HOME/.config/"
cp -r "$RUTA/config/kitty" "$HOME/.config/"
cp -r "$RUTA/config/eww" "$HOME/.config/"
cp -r "$RUTA/config/starship" "$HOME/.config/"
cp -r "$RUTA/config/cava" "$HOME/.config/"
cp -r "$RUTA/config/rofi" "$HOME/.config/"
cp -r "$RUTA/config/bin" "$HOME/.config/"

if [ -d "$RUTA/config/sxhkd" ]; then
    rm -rf "$HOME/.config/sxhkd"
    cp -r "$RUTA/config/sxhkd" "$HOME/.config/"
fi

if [ -d "$RUTA/wallpapers" ]; then
    rm -rf "$HOME/wallpapers"
    cp -r "$RUTA/wallpapers" "$HOME/"
fi

if [ -d "$RUTA/local" ]; then
    mkdir -p "$HOME/.local"
    cp -r "$RUTA/local/"* "$HOME/.local/"
fi

echo "[*] Copiando fuentes..."
if [ -d "$RUTA/fonts" ]; then
    sudo mkdir -p /usr/local/share/fonts
    sudo cp "$RUTA/fonts/"* /usr/local/share/fonts/
    fc-cache -fv
fi

echo "[*] Aplicando permisos..."
find "$HOME/.config/bin" -type f -name "*.sh" -exec chmod +x {} \;
chmod +x "$HOME/.config/bspwm/bspwmrc" 2>/dev/null || true
chmod +x "$HOME/.config/polybar/"*.sh 2>/dev/null || true

echo "[*] Configurando ZSH usuario..."
if [ -f "$RUTA/zshrc" ]; then
    cp "$RUTA/zshrc" "$HOME/.zshrc"
fi

echo "[*] Configurando ZSH root..."
sudo mkdir -p /root/.config
if [ -d "$RUTA/root/starship" ]; then
    sudo rm -rf /root/.config/starship
    sudo cp -r "$RUTA/root/starship" /root/.config/
fi

if [ -f "$RUTA/root/zshrc" ]; then
    sudo cp "$RUTA/root/zshrc" /root/.zshrc
fi

if [ -f "$RUTA/root/sudo.plugin.zsh" ]; then
    sudo mkdir -p /usr/share/zsh-sudo
    sudo cp "$RUTA/root/sudo.plugin.zsh" /usr/share/zsh-sudo/sudo.plugin.zsh
fi

echo "[*] Corrigiendo permisos de completions..."
sudo chown root:root /usr/local/share/zsh/site-functions/_bspc 2>/dev/null || true

echo "[*] Reiniciando servicios visuales..."
pkill polybar 2>/dev/null || true
pkill eww 2>/dev/null || true
pkill picom 2>/dev/null || true

echo "[✓] Migración completada."
echo "[i] Backup guardado en: $BACKUP"
echo "[i] Cierra sesión y vuelve a entrar en BSPWM."
