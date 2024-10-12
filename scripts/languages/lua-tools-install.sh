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
    echo "Installing Stylua..."
    cargo install stylua

    # Verify installation
    if command -v stylua &> /dev/null; then
        echo "Stylua has been successfully installed."
    else
        echo "Failed to install Stylua."
        exit 1
    fi
}

# Run the installation function
install_stylua

# Install lua-language-server
#
# Function to install dependencies
install_dependencies() {
    echo "Installing dependencies..."
    # Adjust this command according to your system
    sudo apt install -y git cmake gcc g++ make
}

# Function to install the Lua Language Server from source
install_lua_language_server() {
    echo "Cloning the Lua Language Server repository..."
    git clone https://github.com/sumneko/lua-language-server.git

    echo "Building the Lua Language Server..."
    cd lua-language-server

    echo "Initializing submodules..."
    git submodule update --init

    mkdir -p build
    cd build
    cmake .. -DCMAKE_BUILD_TYPE=Release
    make

    echo "Installing Lua Language Server..."
    sudo cp -r bin/* /usr/local/bin/

    # Clean up
    cd ../../
    rm -rf lua-language-server

    echo "Lua Language Server has been successfully installed."
}

# Check for dependencies (install if missing)
if ! command -v git &> /dev/null || ! command -v cmake &> /dev/null || ! command -v gcc &> /dev/null || ! command -v make &> /dev/null; then
    install_dependencies
fi

# Run the installation function
install_lua_language_server
