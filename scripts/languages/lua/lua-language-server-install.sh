#!/bin/bash

# Exit the script if any command fails
set -e

# Function to install Stylua using Cargo
install_stylua() {
    # Check if Cargo is installed
    if ! command -v cargo &> /dev/null; then
        echo "Cargo is not installed. Please install Rust and Cargo first."
        exit 1
    fi

    # Install Stylua
    echo "Installing/Updating Stylua..."
    cargo install stylua

    # Verify installation
    if command -v stylua &> /dev/null; then
        echo "Stylua has been successfully installed or updated."
    else
        echo "Failed to install Stylua."
        exit 1
    fi
}

# Run the Stylua installation function
install_stylua

# Install or update lua-language-server

# Function to check if Lua Language Server is installed
is_lua_language_server_installed() {
    if command -v lua-language-server &> /dev/null; then
        return 0  # Installed
    else
        return 1  # Not installed
    fi
}

# Function to fetch the latest version of Lua Language Server from GitHub
fetch_latest_lua_language_server_version() {
    LATEST_VERSION=$(curl -s https://api.github.com/repos/sumneko/lua-language-server/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
    echo "$LATEST_VERSION"
}

# Function to clean up old Lua Language Server installation
clean_old_lua_language_server() {
    if [ -f /usr/local/bin/lua-language-server ]; then
        echo "Removing old Lua Language Server binary..."
        sudo rm /usr/local/bin/lua-language-server
    elif [ -d /usr/local/bin/lua-language-server ]; then
        echo "Removing old Lua Language Server directory..."
        sudo rm -rf /usr/local/bin/lua-language-server
    fi
}

# Function to install or update Lua Language Server
install_or_update_lua_language_server() {
    # Check if Lua Language Server is already installed
    if is_lua_language_server_installed; then
        echo "Lua Language Server is already installed. Checking for updates..."
        CURRENT_VERSION=$(lua-language-server --version | grep -oP '[0-9]+\.[0-9]+\.[0-9]+')

        # Fetch the latest version from GitHub
        LATEST_VERSION=$(fetch_latest_lua_language_server_version)

        # Compare versions
        if [ "$CURRENT_VERSION" == "$LATEST_VERSION" ]; then
            echo "Lua Language Server is already up-to-date (version $CURRENT_VERSION)."
            return
        else
            echo "Updating Lua Language Server from version $CURRENT_VERSION to $LATEST_VERSION..."
        fi
    else
        echo "Lua Language Server is not installed. Installing the latest version..."
    fi

    # Remove any existing Lua Language Server installation (file or directory)
    clean_old_lua_language_server

    # Clone the Lua Language Server repository with submodules
    git clone https://github.com/sumneko/lua-language-server --recurse-submodules

    # Navigate to the source directory
    cd lua-language-server

    # Build the build tool (luamake)
    cd 3rd/luamake
    ./compile/install.sh

    # Go back to the main directory and use luamake to build the server
    cd ../..
    ./3rd/luamake/luamake rebuild

    # Copy the output binary files to a system-wide directory
    sudo cp -r bin/* /usr/local/bin/

    # Clean up by removing the source directory if needed
    cd ..
    rm -rf lua-language-server

    echo "Lua Language Server has been successfully installed or updated to version $LATEST_VERSION."
}

# Run the Lua Language Server installation function
install_or_update_lua_language_server
