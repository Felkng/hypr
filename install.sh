#!/bin/bash

# Exit on error
set -e

echo "Starting installation..."

# Packages to install
PACKAGES=(
    hyprland
    kitty
    waybar
    walker-bin
    swaync
    waypaper
    swww
    nautilus
    brightnessctl
    playerctl
    wireplumber
    wl-clipboard
    cliphist
    pavucontrol
    hyprland-guiutils
    fzf
    grim
    slurp
    libnotify
    neofetch
)

# Function to check if a package is installed
is_installed() {
    pacman -Qi "$1" &> /dev/null
}

# Check if yay is installed
if ! command -v yay &> /dev/null; then
    echo "yay not found. Installing yay..."
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf yay
fi

# Install packages
echo "Installing packages..."
yay -S --needed "${PACKAGES[@]}"

# Define dotfiles directory
DOTFILES_DIR=$(cd "$(dirname "$0")" && pwd)

# Function to create symlink with backup
link_config() {
    local src="$1"
    local dest="$2"
    
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        if [ ! -L "$dest" ] || [ "$(readlink -f "$dest")" != "$src" ]; then
            echo "Backing up existing $dest to ${dest}.bak"
            mv "$dest" "${dest}.bak"
            ln -sf "$src" "$dest"
        else
            echo "$dest is already symlinked correctly."
        fi
    else
        echo "Linking $src to $dest"
        mkdir -p "$(dirname "$dest")"
        ln -sf "$src" "$dest"
    fi
}

# Link configurations
echo "Setting up symlinks..."

link_config "$DOTFILES_DIR/hypr" "$HOME/.config/hypr"
link_config "$DOTFILES_DIR/kitty" "$HOME/.config/kitty"
link_config "$DOTFILES_DIR/waybar" "$HOME/.config/waybar"
link_config "$DOTFILES_DIR/walker" "$HOME/.config/walker"
link_config "$DOTFILES_DIR/swaync" "$HOME/.config/swaync"
link_config "$DOTFILES_DIR/waypaper" "$HOME/.config/waypaper"
link_config "$DOTFILES_DIR/neofetch" "$HOME/.config/neofetch"

# Link scripts in bin
mkdir -p "$HOME/.local/bin"
for script in "$DOTFILES_DIR/bin/"*; do
    if [ -f "$script" ]; then
        link_config "$script" "$HOME/.local/bin/$(basename "$script")"
    fi
done

echo "Installation complete!"
