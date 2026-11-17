# Dotfiles - Hyprland & Wayland Desktop

Este repositório contém as configurações pessoais (dotfiles) para um ambiente desktop moderno baseado no **Hyprland** (Wayland) no Arch Linux.

## 🚀 O que este repositório instala?

O script de instalação configura os seguintes componentes:

- **Gerenciador de Janelas:** [Hyprland](https://hyprland.org/)
- **Emulador de Terminal:** [Kitty](https://sw.kovidgoyal.net/kitty/)
- **Barra de Status:** [Waybar](https://github.com/Alexays/Waybar)
- **Lançador de Apps:** [Walker](https://github.com/abenz1267/walker)
- **Centro de Notificações:** [SwayNC](https://github.com/ErikReider/SwayNotificationCenter)
- **Gerenciador de Wallpaper:** [Waypaper](https://github.com/anandbaraik/waypaper) (com `swww`)
- **Bloqueio de Tela:** [Hyprlock](https://wiki.hypr.land/Hypr-ecosystem/hyprlock/)
- **Login Manager:** [SDDM](https://github.com/sddm/sddm) (com tema [Tokyo Night](https://github.com/siddrs/tokyo-night-sddm))
- **Outros utilitários:** `neofetch`, `fzf`, `grim`, `slurp`, `brightnessctl`, `playerctl`, `cliphist`, etc.

## 📦 Instalação

### Pré-requisitos
- Sistema operacional **Arch Linux**.
- Conexão com a internet para baixar pacotes via AUR.

### Como usar em uma máquina nova
1. Clone o repositório:
   ```bash
   git clone https://github.com/Felkng/hypr.git ~/dotfiles
   cd ~/dotfiles
   ```
2. Dê permissão de execução aos scripts:
   ```bash
   chmod +x install.sh bin/*
   ```
3. Execute a instalação:
   ```bash
   ./install.sh
   # ou: ./bin/dotsync install
   ```
   *O script instalará o `yay` se necessário, todos os pacotes e utilitários necessários para o Hyprland, criará links simbólicos em `~/.config/` e configurará o SDDM e wallpapers automaticamente.*

## 🛠️ Scripts Personalizados (`bin/`)

Os scripts são instalados em `~/.local/bin/` e podem ser chamados diretamente:

- **`dotsync`**: Gerenciador de sincronização dos dotfiles (pull, push e install).
- **`open-yayfzf.sh`**: Abre o `yayfzf` em uma janela flutuante do Kitty para busca rápida de pacotes.
- **`wallpaper-picker.sh`**: Interface via `walker --dmenu` para selecionar e aplicar wallpapers da sua pasta `~/Downloads` ou `~/Pictures/Wallpapers`.
- **`droidcam-setup`**: Configura automaticamente o `v4l2loopback` com 2 dispositivos virtuais (DroidCam e OBS Virtual Camera) para garantir compatibilidade com Google Chrome e Chromium.

## 🔄 Sincronização e Manutenção (`dotsync`)

Para manter o repositório atualizado ou sincronizar entre máquinas, utilize o comando **`dotsync`**:

- **Subir modificações:**
  ```bash
  dotsync "Sua mensagem opcional"
  ```
- **Baixar modificações e atualizar links:**
  ```bash
  dotsync pull
  ```
- **Reinstalar pacotes e restaurar links:**
  ```bash
  dotsync install
  ```
- **Verificar status:**
  ```bash
  dotsync status
  ```
