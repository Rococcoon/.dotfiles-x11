#!/bin/bash
# Script to symlink config files
# By: LRBM

set -e  # Exit on any error

# Function to remove existing configurations
remove_existing() {
    local target="$1"
    if [ -e "$target" ] || [ -L "$target" ]; then
        echo "Removing existing $target..."
        rm -rf "$target"
    fi
}

# Remove existing configurations
remove_existing ~/.bashrc
remove_existing ~/.config/alacritty
remove_existing ~/.config/i3
remove_existing ~/.config/nvim
remove_existing ~/.config/nvim.bak
remove_existing ~/.config/picom
remove_existing ~/.config/polybar
remove_existing ~/.config/ranger
remove_existing ~/.config/rofi
remove_existing ~/.vimrc
remove_existing ~/.vim
remove_existing ~/.tmux.conf
remove_existing ~/.tmux
remove_existing ~/.wallpapers

# Configuration Files Symlinking

# bash
ln -sf ~/.dotfiles/ScarletRice01/config/bash/bashrc ~/.bashrc
echo "Old Alacritty config removed and symlink created."


# Alacritty
ln -sf ~/.dotfiles/ScarletRice01/config/alacritty ~/.config/
echo "Old Alacritty config removed and symlink created."

# i3
ln -sf ~/.dotfiles/ScarletRice01/config/i3 ~/.config
echo "Old i3 config removed and symlink created."

# Neovim
ln -sf ~/.dotfiles/ScarletRice01/config/nvim ~/.config
echo "Old Neovim config removed and symlink created."

# Neovim backup
ln -sf ~/.dotfiles/ScarletRice01/config/nvim.bak ~/.config
echo "Old Neovim backup config removed and symlink created."

# Picom
ln -sf ~/.dotfiles/ScarletRice01/config/picom ~/.config
echo "Old Picom backup config removed and symlink created."

# Polybar
ln -sf ~/.dotfiles/ScarletRice01/config/polybar ~/.config
echo "Old Polybar backup config removed and symlink created."

# Ranger
ln -sf ~/.dotfiles/ScarletRice01/config/ranger ~/.config
echo "Old Ranger backup config removed and symlink created."

# Rofi
ln -sf ~/.dotfiles/ScarletRice01/config/rofi ~/.config
echo "Old Rofi backup config removed and symlink created."

# Vim
ln -sf ~/.dotfiles/ScarletRice01/config/vim/vimrc ~/.vimrc
echo "Old vim config removed and symlink created."

# Wallpaper
ln -sf ~/.dotfiles/ScarletRice01/wallpapers/ ~/.wallpapers
echo "Old vim config removed and symlink created."

# Tmux
ln -sf ~/.dotfiles/ScarletRice01/config/tmux/tmux.conf ~/.tmux.conf
echo "Old tmux.conf removed and symlink created."

# Clone TPM (Tmux Plugin Manager) if not already installed
if [ ! -d ~/.tmux/plugins/tpm ]; then
    echo "Cloning TPM (Tmux Plugin Manager)..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo "TPM (Tmux Plugin Manager) cloned."
else
    echo "TPM is already installed."
fi

# Install plugins using TPM
echo "Installing tmux plugins..."
~/.tmux/plugins/tpm/bin/install_plugins
echo "tmux plugins installed."

echo "All configuration files symlinked and plugins installed successfully."
