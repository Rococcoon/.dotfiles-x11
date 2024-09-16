#!/bin/bash

# Set up script for ScarletRice1
# By: LBRM
# Run the script as root user

# Switch to root user and execute commands
# su -

# Update system and upgrade existing packages
echo "Updating system and upgrading existing packages..."
if ! sudo apt update; then
  echo "Failed to update package list"
  exit 1
fi
if ! sudo apt upgrade -y; then
  echo "Failed to upgrade packages"
  exit 1
fi


############################ INSTALLATIONS ##################################

# Install Build Tools
echo "Installing build tools..."
if ! sudo apt install -y build-essential pkg-config cmake; then
  echo "Failed to install build tools"
  exit 1
fi

# Development headers for x11 libraries
echo "Installing development headers for x11 libraries..."
if ! sudo apt install -y libx11-dev libxft-dev libxinerama-dev; then
  echo "Failed to install x11 development headers"
  exit 1
fi

# Install Core Utilities
echo "Installing core utilities..."
if ! sudo apt install -y git wget curl xclip unzip checkinstall; then
  echo "Failed to install core utilities"
  exit 1
fi

# Install GTK Toolkit
echo "Installing GTK toolkit..."
if ! sudo apt install -y libgtk-3-dev libgtk2.0-dev; then
  echo "Failed to install GTK toolkit"
  exit 1
fi

# Install Xorg
echo "Installing Xorg..."
if ! sudo apt install -y xorg; then
  echo "Failed to install Xorg"
  exit 1
fi

# Install Compositor for x11
echo "Installing compositor (picom)..."
if ! sudo apt install -y picom; then
  echo "Failed to install picom"
  exit 1
fi

# Install Image Viewer for x11
echo "Installing image viewer (feh)..."
if ! sudo apt install -y feh; then
  echo "Failed to install feh"
  exit 1
fi

# Install AMD graphics drivers and necessary firmware for Asus rx 580
# echo "Installing AMD graphics drivers and firmware..."
# if ! sudo apt install -y mesa-utils xserver-xorg-video-amdgpu firmware-amd-graphics; then
  # echo "Failed to install AMD graphics drivers and firmware"
  # exit 1
# fi

# Install Monitoring Tool
echo "Installing monitoring tools..."
if ! sudo apt install -y sysstat htop; then
  echo "Failed to install monitoring tools"
  exit 1
fi

# Install File Navigation
echo "Installing file navigation tool (ranger)..."
if ! sudo apt install -y ranger; then
  echo "Failed to install ranger"
  exit 1
fi

# Install Bluetooth Utilities
echo "Installing Bluetooth utilities..."
if ! sudo apt install -y bluetooth bluez; then
  echo "Failed to install Bluetooth utilities"
  exit 1
fi

# Install Wifi Utilities
echo "Installing Wifi utilities..."
if ! sudo apt install -y network-manager --no-install-recommends; then
  echo "Failed to install Wifi utilities"
  exit 1
fi

# Install Text Editor
echo "Installing text editor (vim)..."
if ! sudo apt install -y vim; then
  echo "Failed to install vim"
  exit 1
fi

# Install Audio Utilities
echo "Installing audio utilities (pulseaudio)..."
if ! sudo apt install -y pulseaudio; then
  echo "Failed to install pulseaudio"
  exit 1
fi

# Install Terminal Emulator (Alacritty)
echo "Installing terminal emulator (Alacritty)..."
if ! sudo apt install -y alacritty; then
  echo "Failed to install Alacritty"
  exit 1
fi

# Install Terminal Multiplexer (tmux)
echo "Installing terminal multiplexer (tmux)..."
if ! sudo apt install -y tmux; then
  echo "Failed to install tmux"
  exit 1
fi

# Install Window Manager (i3)
echo "Installing window manager (i3)..."
if ! sudo apt install -y i3 i3status i3lock dmenu; then
  echo "Failed to install i3 and related utilities"
  exit 1
fi

# Install Desktop Applications
echo "Installing desktop applications (rofi, polybar)..."
if ! sudo apt install -y rofi polybar; then
  echo "Failed to install rofi and polybar"
  exit 1
fi

# Install Image Editor (Inkscape, GIMP)
echo "Installing image editors (Inkscape, GIMP)..."
if ! sudo apt install -y gimp inkscape; then
  echo "Failed to install Inkscape and GIMP"
  exit 1
fi

# Install GitHub CLI
echo "Installing GitHub CLI..."
if ! curl -fsSL \
  https://cli.github.com/packages/githubcli-archive-keyring.gpg \
  | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg; then
  echo "Failed to download GitHub CLI keyring"
  exit 1
fi
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] \
  https://cli.github.com/packages stable main" \
  | sudo tee /etc/apt/sources.list.d/github-cli.list
if ! sudo apt update; then
  echo "Failed to update package list"
  exit 1
fi
if ! sudo apt install -y gh; then
  echo "Failed to install GitHub CLI"
  exit 1
fi

# Install Web Browser (Brave)
echo "Installing web browser (Brave)..."
if ! sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
  https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg; then
  echo "Failed to download Brave keyring"
  exit 1
fi
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] \
  https://brave-browser-apt-release.s3.brave.com/ stable main" \
  | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
if ! sudo apt update; then
  echo "Failed to update package list"
  exit 1
fi
if ! sudo apt install -y brave-browser; then
  echo "Failed to install Brave browser"
  exit 1
fi

# Install fuse for AppImage launch
echo "Installing FUSE..."
if sudo apt install fuse -y; then
  echo "FUSE installed successfully."
else
  echo "Failed to install FUSE. Please check your package manager and try again."
  exit 1
fi

# Install Text Editor (nvim)
echo "Installing Neovim..."
# Download the Neovim AppImage
if ! curl -L -o nvim.appimage \
  https://github.com/neovim/neovim/releases/download/stable/nvim.appimage; then
  echo "Failed to download Neovim AppImage"
  exit 1
fi
# Make the AppImage executable
if ! chmod +x nvim.appimage; then
  echo "Failed to make Neovim AppImage executable"
  exit 1
fi
# Move the AppImage to a directory in PATH (e.g., /usr/local/bin)
if ! sudo mv nvim.appimage /usr/local/bin/nvim; then
  echo "Failed to move Neovim AppImage to /usr/local/bin"
  exit 1
fi
# Install ripgrep for telescope
echo "Installing ripgrep..."
if ! sudo apt install -y ripgrep; then
  echo "Failed to install ripgrep"
  exit 1
fi

# Install WebI package manager for Web Development
echo "Installing WebI package manager..."
if ! curl -sS https://webinstall.dev/webi | bash; then
  echo "Failed to install WebI"
  exit 1
fi

echo "Installations completed successfully."

# Install oh my bash 
# Function to print messages in different colors
function print_message {
    echo -e "\e[1;32m$1\e[0m"
}
# Step 1: Install Git if not already installed
if ! command -v git &> /dev/null; then
    print_message "Installing Git..."
    sudo apt update && sudo apt install -y git
else
    print_message "Git is already installed."
fi
# Step 2: Install Oh My Bash
print_message "Installing Oh My Bash..."
bash -c \
  "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
# Step 3: Set the theme to Agnoster in ~/.bashrc
print_message "Setting Oh My Bash theme to Agnoster..."
sed -i 's/^OSH_THEME=.*/OSH_THEME="agnoster"/' ~/.bashrc
# Step 4: Add custom tab behavior to ~/.bashrc (cycling and menu-complete)
print_message "Configuring custom tab behavior..."
# Check if the settings already exist and append if they do not
if ! grep -q 'set show-all-if-ambiguous on' ~/.bashrc; then
    echo "# Enable tab cycling for multiple matches" >> ~/.bashrc
    echo "bind 'set show-all-if-ambiguous on'" >> ~/.bashrc
    echo "bind 'set completion-ignore-case on'" >> ~/.bashrc
fi
if ! grep -q 'TAB:menu-complete' ~/.bashrc; then
    echo "# Enable menu completion for cycling through options with Tab" >> \
      ~/.bashrc
    echo "bind 'TAB:menu-complete'" >> ~/.bashrc
fi
# Step 5: Apply the changes by sourcing ~/.bashrc
print_message "Applying changes..."
source ~/.bashrc

print_message "Oh My Bash installation and configuration complete!"

print_message "System setup up installation complete"
