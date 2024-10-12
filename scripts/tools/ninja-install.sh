#!/bin/bash

# Exit if any command fails
set -e

# Function to fetch the latest Ninja version
fetch_latest_ninja_version() {
    # Fetch the latest release tag from Ninja's GitHub and remove any "v" prefix
    LATEST_VERSION=$(curl -s https://api.github.com/repos/ninja-build/ninja/releases/latest | \
        grep -oP '"tag_name": "\K(.*)(?=")' | sed 's/^v//')

    if [ -n "$LATEST_VERSION" ]; then
        echo "$LATEST_VERSION"
    else
        echo "Error: Failed to fetch the latest Ninja version." >&2
        exit 1
    fi
}

# Function to get the currently installed Ninja version
get_installed_ninja_version() {
    if command -v ninja &> /dev/null; then
        INSTALLED_VERSION=$(ninja --version)
    else
        INSTALLED_VERSION="0.0.0"  # Return a low version if not installed
    fi
}

# Function to install or update Ninja
install_or_update_ninja() {
    LATEST_VERSION=$(fetch_latest_ninja_version)
    get_installed_ninja_version

    if [ "$INSTALLED_VERSION" == "$LATEST_VERSION" ]; then
        echo "Ninja is already up-to-date (version $INSTALLED_VERSION)."
    else
        echo "Installing/Updating Ninja from version $INSTALLED_VERSION to $LATEST_VERSION..."

        # Download the latest Ninja tarball
        curl -LO "https://github.com/ninja-build/ninja/archive/refs/tags/v$LATEST_VERSION.tar.gz"

        # Extract the tarball
        tar -xzf "v$LATEST_VERSION.tar.gz"

        # Change to the extracted directory
        cd "ninja-$LATEST_VERSION"

        # Build Ninja using the bootstrap script
        ./configure.py --bootstrap

        # Copy the Ninja executable to /usr/local/bin (or your preferred location)
        sudo cp ninja /usr/local/bin/

        # Clean up
        cd ..
        rm -rf "ninja-$LATEST_VERSION" 
        rm "v$LATEST_VERSION.tar.gz"

        echo "Ninja has been successfully updated to version $LATEST_VERSION."
    fi
}

# Run the install/update function
install_or_update_ninja
