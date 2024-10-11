#!/bin/bash

# Exit the script if any command fails
set -e

# Variables
LUA_URL="https://www.lua.org/ftp/"
INSTALL_DIR="/usr/local"
OLD_LUA_DIR="$INSTALL_DIR/bin/lua"
OLD_LUA_INCDIR="$INSTALL_DIR/include/lua"
OLD_LUA_LIBDIR="$INSTALL_DIR/lib/liblua.a"

# Function to get the latest Lua version from the official site
get_latest_version() {
    curl -s $LUA_URL | grep -oP 'lua-\K[0-9]+\.[0-9]+\.[0-9]+' | sort -V | tail -1
}

# Function to get the currently installed Lua version
get_installed_version() {
    if command -v lua >/dev/null 2>&1; then
        lua -v 2>&1 | grep -oP 'Lua \K[0-9]+\.[0-9]+\.[0-9]+'
    else
        echo "No Lua installed"
    fi
}

# Function to clean up the old Lua files
cleanup_old_lua() {
    echo "Cleaning up old Lua installation..."
    
    # Remove old binaries, headers, and libraries
    sudo rm -f $OLD_LUA_DIR
    sudo rm -rf $OLD_LUA_INCDIR
    sudo rm -f $OLD_LUA_LIBDIR

    echo "Old Lua installation removed."
}

# Main script logic

# Fetch the latest and installed Lua versions
LATEST_VERSION=$(get_latest_version)
INSTALLED_VERSION=$(get_installed_version)

# Compare the versions
if [ "$LATEST_VERSION" = "$INSTALLED_VERSION" ]; then
    echo "Lua is already up to date (version $INSTALLED_VERSION)"
    exit 0
elif [ -z "$INSTALLED_VERSION" ]; then
    echo "No Lua installation found. Proceeding to install Lua $LATEST_VERSION..."
else
    echo "Updating Lua from version $INSTALLED_VERSION to $LATEST_VERSION..."
    cleanup_old_lua
fi

# Download the latest version
LUA_TARBALL="lua-$LATEST_VERSION.tar.gz"
echo "Downloading Lua $LATEST_VERSION..."
curl -R -O "$LUA_URL/$LUA_TARBALL"

# Extract the source
echo "Extracting Lua $LATEST_VERSION..."
tar zxf "$LUA_TARBALL"

# Build and install Lua
cd "lua-$LATEST_VERSION"
echo "Building Lua $LATEST_VERSION..."
make linux

echo "Installing Lua $LATEST_VERSION..."
sudo make INSTALL_TOP=$INSTALL_DIR install

# Clean up
cd ..
rm -rf "lua-$LATEST_VERSION"
rm "$LUA_TARBALL"

# Verify the installation
echo "Lua has been updated successfully!"
lua -v
