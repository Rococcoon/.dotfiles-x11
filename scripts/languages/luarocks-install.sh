#!/bin/bash

# Exit the script if any command fails
set -e

# Function to fetch and display the LuaRocks releases page and extract the latest version
fetch_latest_luarocks_version() {

    # Fetch the releases page and extract version numbers
    LATEST_VERSION=$(curl -s -L https://luarocks.org/releases/ | \
        grep -oP 'href="luarocks-\K[0-9]+\.[0-9]+\.[0-9]+' | \
        sort -V | \
        tail -1)

    # Check if a version was found and return it
    if [ -n "$LATEST_VERSION" ]; then
        echo "$LATEST_VERSION"
    else
        echo "Failed to find the latest LuaRocks version."
        exit 1
    fi
}

# Function to get the currently installed LuaRocks version
get_installed_luarocks_version() {
    if command -v luarocks &> /dev/null; then
        INSTALLED_VERSION=$(luarocks --version | grep -oP '[0-9]+\.[0-9]+\.[0-9]+')
        echo "Installed LuaRocks version is: $INSTALLED_VERSION"
        echo "$INSTALLED_VERSION"
    else
        echo "0.0.0"  # Return a version that is less than any valid version
    fi
}

# Function to install or update LuaRocks
install_or_update_luarocks() {
    LATEST_VERSION=$(fetch_latest_luarocks_version)
    INSTALLED_VERSION=$(get_installed_luarocks_version)

    # Compare versions
    if [ "$INSTALLED_VERSION" == "$LATEST_VERSION" ]; then
        echo "LuaRocks is already up-to-date."
    else
        echo "Updating LuaRocks from version $INSTALLED_VERSION to $LATEST_VERSION..."
        
        # Download the latest LuaRocks
        curl -R -O "https://luarocks.org/releases/luarocks-$LATEST_VERSION.tar.gz"

        # Extract the downloaded tarball
        tar -xzvf "luarocks-$LATEST_VERSION.tar.gz"

        # Change directory to the extracted folder
        cd "luarocks-$LATEST_VERSION"

        # Install LuaRocks
        ./configure --with-lua=/usr/local/bin/lua
        make
        sudo make install

        # Clean up
        cd ..
        rm -rf "luarocks-$LATEST_VERSION" "luarocks-$LATEST_VERSION.tar.gz"

        echo "LuaRocks has been successfully updated to version $LATEST_VERSION."
    fi
}

# Run the install or update function
install_or_update_luarocks
