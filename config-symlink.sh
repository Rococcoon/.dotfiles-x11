#!/bin/bash
# Script to symlink config files
# By: LRBM

set -e  # Exit on any error

# Backup directory with timestamp
backup_dir="$HOME/.config-backup/config-backup-ScarletRice1-$(date +%F_%T)"
mkdir -p "$backup_dir"

# Function to copy contents of a symlink or directory
copy_symlink_target() {
    local dir="$1"
    local backup_dir="$2"

    if [ -L "$dir" ]; then
        # If it's a symlink, copy the target's content
        local target=$(readlink -f "$dir")
        echo "Copying symlink target $target to $backup_dir..."
        mkdir -p "$backup_dir/$(basename "$target")"
        cp -r "$target" "$backup_dir/$(basename "$target")"
        echo "Symlink target copied to backup directory."
    elif [ -e "$dir" ]; then
        # If it's a file or directory (not a symlink), move it to the backup directory
        echo "Backing up existing directory or file $dir to $backup_dir..."
        mv "$dir" "$backup_dir"
        echo "Backup completed."
    fi
}

# Remove and backup existing configurations
copy_symlink_target ~/.config/alacritty "$backup_dir/alacritty"
copy_symlink_target ~/.config/i3 "$backup_dir/i3"
copy_symlink_target ~/.config/nvim "$backup_dir/nvim"
copy_symlink_target ~/.config/nvim.bak "$backup_dir/nvim.bak"
copy_symlink_target ~/.config/picom "$backup_dir/picom"
copy_symlink_target ~/.config/polybar "$backup_dir/polybar"
copy_symlink_target ~/.config/ranger "$backup_dir/ranger"
copy_symlink_target ~/.config/rofi "$backup_dir/rofi"
copy_symlink_target ~/.vimrc "$backup_dir/vimrc"
copy_symlink_target ~/.vim "$backup_dir/vim"
copy_symlink_target ~/.tmux.conf "$backup_dir/tmux.conf"
copy_symlink_target ~/.tmux "$backup_dir/tmux"

# Create necessary directories
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/i3
mkdir -p ~/.config/nvim
mkdir -p ~/.tmux/plugins

# Configuration Files Symlinking

# Alacritty
ln -sf ~/Rices/ScarletRice1/config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
echo "Old Alacritty config removed and symlink created."

# i3
ln -sf ~/Rices/ScarletRice1/config/i3/config ~/.config/i3/config
echo "Old i3 config removed and symlink created."

# Neovim
ln -sf ~/Rices/ScarletRice1/config/nvim ~/.config/nvim
echo "Old Neovim config removed and symlink created."

# Neovim backup
ln -sf ~/Rices/ScarletRice1/config/nvim.bak ~/.config/nvim.bak
echo "Old Neovim backup config removed and symlink created."

# Picom
ln -sf ~/Rices/ScarletRice1/config/picom ~/.config/picom
echo "Old Picom backup config removed and symlink created."

# Polybar
ln -sf ~/Rices/ScarletRice1/config/polybar ~/.config/polybar
echo "Old Polybar backup config removed and symlink created."

# Ranger
ln -sf ~/Rices/ScarletRice1/config/ranger ~/.config/ranger
echo "Old Ranger backup config removed and symlink created."

# Rofi
ln -sf ~/Rices/ScarletRice1/config/rofi ~/.config/rofi
echo "Old Rofi backup config removed and symlink created."

# Vim
ln -sf ~/Rices/ScarletRice1/config/vim/vimrc ~/.vimrc
echo "Old vim config removed and symlink created."

# Tmux
ln -sf ~/Rices/ScarletRice1/config/tmux/tmux.conf ~/.tmux.conf
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
