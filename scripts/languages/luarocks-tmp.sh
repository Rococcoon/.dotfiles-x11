#!/bin/bash

# Exit the script if any command fails
set -e

# Function to fetch and display the LuaRocks releases page and extract the latest version
fetch_latest_luarocks_version() {
    echo "Fetching LuaRocks releases..."

    # Fetch the releases page and extract version numbers
    LATEST_VERSION=$(curl -s -L https://luarocks.org/releases/ | \
        grep -oP 'href="luarocks-\K[0-9]+\.[0-9]+\.[0-9]+' | \
        sort -V | \
        tail -1)

    # Check if a version was found and display it
    if [ -n "$LATEST_VERSION" ]; then
        echo "Latest LuaRocks version is: $LATEST_VERSION"
    else
        echo "Failed to find the latest LuaRocks version."
    fi
}

# Call the function to fetch the latest version
fetch_latest_luarocks_version
