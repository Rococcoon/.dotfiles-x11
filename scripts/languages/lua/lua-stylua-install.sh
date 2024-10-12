#!/bin/bash

# Exit the script if any command fails
set -e

# Function to install or update Stylua using Cargo
install_or_update_stylua() {
    # Check if Cargo is installed
    if ! command -v cargo &> /dev/null; then
        echo "Cargo is not installed. Please install Rust and Cargo first."
        exit 1
    fi

    # Check if Stylua is already installed
    if command -v stylua &> /dev/null; then
        echo "Stylua is already installed. Checking for updates..."

        # Get the installed version of Stylua
        CURRENT_VERSION=$(stylua --version | grep -oP 'stylua ([0-9]+\.[0-9]+\.[0-9]+)' | awk '{print $2}')

        # Get the latest version of Stylua available via Cargo
        LATEST_VERSION=$(cargo search stylua | grep -oP 'stylua = "([0-9]+\.[0-9]+\.[0-9]+)"' | awk -F'"' '{print $2}')

        # Compare installed version with the latest available version
        if [ "$CURRENT_VERSION" == "$LATEST_VERSION" ]; then
            echo "Stylua is already up-to-date (version $CURRENT_VERSION)."
            return
        else
            echo "Updating Stylua from version $CURRENT_VERSION to $LATEST_VERSION..."
        fi
    else
        echo "Stylua is not installed. Installing the latest version..."
    fi

    # Install or update Stylua using Cargo
    cargo install stylua --force

    # Verify installation
    if command -v stylua &> /dev/null; then
        NEW_VERSION=$(stylua --version | grep -oP 'stylua ([0-9]+\.[0-9]+\.[0-9]+)' | awk '{print $2}')
        echo "Stylua has been successfully installed or updated to version $NEW_VERSION."
    else
        echo "Failed to install or update Stylua."
        exit 1
    fi
}

# Run the installation or update function
install_or_update_stylua
