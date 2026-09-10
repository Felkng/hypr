#!/bin/bash
# Script para resetar e iniciar os portais do XDG corretamente no Hyprland

# 1. Garantir que as variáveis de ambiente do Wayland estão no DBus/Systemd
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

# 2. Matar processos existentes (se houver)
killall -q xdg-desktop-portal-hyprland
killall -q xdg-desktop-portal-gtk
killall -q xdg-desktop-portal

# 3. Iniciar os backends manualmente para ignorar dependências do systemd que falham no Hyprland
# (como o graphical-session.target que muitas vezes não é ativado corretamente)
/usr/lib/xdg-desktop-portal-hyprland &
sleep 2
/usr/lib/xdg-desktop-portal-gtk &
sleep 1
/usr/lib/xdg-desktop-portal &
