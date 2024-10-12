#!/bin/bash

# Exit script if any command fails
set -e

# Function to install Lua Language Server
install_lua_language_server() {
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

    echo "Lua Language Server has been successfully installed."
}

# Run the install function
install_lua_language_server
