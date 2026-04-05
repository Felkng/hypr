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
- **Outros utilitários:** `neofetch`, `fzf`, `grim`, `slurp`, `brightnessctl`, `playerctl`, `cliphist`, etc.

## 📦 Instalação

### Pré-requisitos
- Sistema operacional **Arch Linux**.
- Conexão com a internet para baixar pacotes via AUR.

### Como usar
1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```
2. Dê permissão de execução ao script:
   ```bash
   chmod +x install.sh
   ```
3. Execute a instalação:
   ```bash
   ./install.sh
   ```
   *O script instalará o `yay` se necessário, os pacotes listados e criará links simbólicos em `~/.config/`.*

## 🛠️ Scripts Personalizados (`bin/`)

Os scripts são instalados em `~/.local/bin/` e podem ser chamados diretamente:

- **`open-yayfzf.sh`**: Abre o `yayfzf` em uma janela flutuante do Kitty para busca rápida de pacotes.
- **`wallpaper-picker.sh`**: Interface via `walker --dmenu` para selecionar e aplicar wallpapers da sua pasta `~/Downloads`.

## 🔄 Sincronização

Para manter o repositório atualizado com as modificações que você fizer no computador, utilize o script de sincronização:

```bash
chmod +x sync.sh
./sync.sh "Mensagem do commit"
```
Ele irá adicionar todas as alterações, criar um commit e realizar o push para o seu repositório remoto.
