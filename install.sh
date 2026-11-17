#!/bin/bash

# Exit on error
set -e

echo "Starting installation..."

# Packages to install
PACKAGES=(
    hyprland
    hyprpaper
    hyprlock
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
    yayfzf
    jq
    zenity
    psmisc
    grim
    slurp
    libnotify
    neofetch
    swappy
    otf-font-awesome
    ttf-roboto-mono-nerd
    sddm-theme-tokyo-night-git
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    elephant-bin
    spotify-tray-wayland-bin
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
link_config "$DOTFILES_DIR/gtk-3.0" "$HOME/.config/gtk-3.0"
link_config "$DOTFILES_DIR/gtk-4.0" "$HOME/.config/gtk-4.0"
link_config "$DOTFILES_DIR/fontconfig" "$HOME/.config/fontconfig"
link_config "$DOTFILES_DIR/swappy" "$HOME/.config/swappy"
link_config "$DOTFILES_DIR/xdg-desktop-portal" "$HOME/.config/xdg-desktop-portal"
link_config "$DOTFILES_DIR/themes/Tokyonight-Dark" "$HOME/.themes/Tokyonight-Dark"
link_config "$DOTFILES_DIR/hypr/wallpapers" "$HOME/Pictures/Wallpapers"

# Link scripts in bin
mkdir -p "$HOME/.local/bin"
for script in "$DOTFILES_DIR/bin/"*; do
    if [ -f "$script" ]; then
        link_config "$script" "$HOME/.local/bin/$(basename "$script")"
    fi
done

# Update font cache
echo "Updating font cache..."
fc-cache -fv

# Configure SDDM
echo "Configuring SDDM theme..."
if [ ! -f /etc/sddm.conf ]; then
    sddm --example-config | sudo tee /etc/sddm.conf > /dev/null
fi
sudo sed -i 's/^Current=.*/Current=tokyo-night-sddm/' /etc/sddm.conf

# Set SDDM wallpaper
WALLPAPER="$DOTFILES_DIR/hypr/wallpapers/default.png"
if [ -f "$WALLPAPER" ]; then
    echo "Setting SDDM wallpaper..."
    sudo mkdir -p /usr/share/sddm/themes/tokyo-night-sddm/Backgrounds
    sudo cp "$WALLPAPER" /usr/share/sddm/themes/tokyo-night-sddm/Backgrounds/current_wallpaper.png
    sudo sed -i 's|^Background=.*|Background="Backgrounds/current_wallpaper.png"|' /usr/share/sddm/themes/tokyo-night-sddm/theme.conf
fi

echo "Installation complete!"
