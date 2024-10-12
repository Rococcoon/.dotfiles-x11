#!/bin/bash

# Exit the script if any command fails
set -e

# Function to fetch the latest LuaRocks version
fetch_latest_luarocks_version() {
    # Fetch the releases page and extract version numbers
    LATEST_VERSION=$(curl -s -L https://luarocks.org/releases/ | \
        grep -oP 'href="luarocks-\K[0-9]+\.[0-9]+\.[0-9]+' | \
        sort -V | \
        tail -1)

    # Check if a version was found and return it
    if [ -n "$LATEST_VERSION" ]; then
        return 0  # Success
    else
        return 1  # Failure
    fi
}

# Function to get the currently installed LuaRocks version
get_installed_luarocks_version() {
    if command -v luarocks &> /dev/null; then
        INSTALLED_VERSION=$(luarocks --version | grep -oP '[0-9]+\.[0-9]+\.[0-9]+')
    else
        INSTALLED_VERSION="0.0.0"  # Return a version that is less than any valid version
    fi
}

# Function to install or update LuaRocks
install_or_update_luarocks() {
    fetch_latest_luarocks_version
    LATEST_VERSION=$LATEST_VERSION
    get_installed_luarocks_version
    INSTALLED_VERSION=$INSTALLED_VERSION

    # Compare versions
    if [ "$INSTALLED_VERSION" == "$LATEST_VERSION" ]; then
        echo "LuaRocks is already up-to-date."
    else
        echo "Updating LuaRocks from version $INSTALLED_VERSION to $LATEST_VERSION..."
        
        # Download the latest LuaRocks
        curl -R -O "https://luarocks.github.io/luarocks/releases/luarocks-$LATEST_VERSION.tar.gz"

        # Check if the download was successful
        if [ ! -f "luarocks-$LATEST_VERSION.tar.gz" ]; then
            echo "Download failed."
            exit 1
        fi

        # Verify that the downloaded file is a gzip archive
        if file "luarocks-$LATEST_VERSION.tar.gz" | grep -q "gzip compressed data"; then
            # Extract the downloaded tarball
            tar -xzvf "luarocks-$LATEST_VERSION.tar.gz"
        else
            echo "Downloaded file is not a valid gzip archive."
            exit 1
        fi

        # Change directory to the extracted folder
        cd "luarocks-$LATEST_VERSION"

        # Install LuaRocks
        ./configure --with-lua=/usr/local
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


