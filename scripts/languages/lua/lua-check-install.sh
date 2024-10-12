#!/bin/bash

# Exit the script if any command fails
set -e

# Function to install or update Luacheck using LuaRocks
install_or_update_luacheck() {
    # Check if LuaRocks is installed
    if ! command -v luarocks &> /dev/null; then
        echo "LuaRocks is not installed. Please install LuaRocks first."
        exit 1
    fi

    # Check if Luacheck is already installed
    if luarocks show luacheck &> /dev/null; then
        echo "Luacheck is already installed. Checking for updates..."

        # Get the installed version of Luacheck
        CURRENT_VERSION=$(luarocks show luacheck | grep -oP '^Installed \K[0-9]+\.[0-9]+\.[0-9]+')

        # Get the latest version of Luacheck available via LuaRocks
        LATEST_VERSION=$(luarocks search luacheck | grep -oP 'luacheck\s+\K[0-9]+\.[0-9]+\.[0-9]+' | head -n 1)

        # Compare installed version with the latest available version
        if [ "$CURRENT_VERSION" == "$LATEST_VERSION" ]; then
            echo "Luacheck is already up-to-date (version $CURRENT_VERSION)."
            return
        else
            echo "Updating Luacheck from version $CURRENT_VERSION to $LATEST_VERSION..."
        fi
    else
        echo "Luacheck is not installed. Installing the latest version..."
    fi

    # Install or update Luacheck using LuaRocks
    sudo luarocks install luacheck --force

    # Verify installation
    if command -v luacheck &> /dev/null; then
        echo "Luacheck has been successfully installed or updated."
    else
        echo "Failed to install or update Luacheck."
        exit 1
    fi
}

# Run the installation or update function
install_or_update_luacheck
