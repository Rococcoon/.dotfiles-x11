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

# Function to install Lua Language Server from source
install_lua_language_server() {
    # Clone the repository
    git clone https://github.com/sumneko/lua-language-server.git

    # Navigate to the source directory
    cd lua-language-server

    # Check if CMakeLists.txt exists
    if [ ! -f "CMakeLists.txt" ]; then
        echo "Error: CMakeLists.txt not found in the source directory."
        exit 1
    fi

    # Create a build directory
    mkdir -p build
    cd build

    # Run CMake to configure the project
    cmake ..
    
    # Build the project
    make

    # Install binaries
    sudo cp -r bin/* /usr/local/bin/

    # Clean up
    cd ../../
    rm -rf lua-language-server

    echo "Lua Language Server has been installed successfully."
}

# Run the installation function
install_lua_language_server
