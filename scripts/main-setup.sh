#!/bin/bash
#
# By: LBRM
# Script to execute all set up scripts

# Array of setup scripts
scripts=(
    "system-setup.sh"
    "font-setup.sh"
    "preference-setup.sh"
    "config-symlink.sh"
)

# Make each script executable
for script in "${scripts[@]}"; do
    if [ -f "$script" ]; then
        echo "Making $script executable..."
        chmod +x "$script"
    else
        echo "Warning: $script not found!"
    fi
done

# Run each script
for script in "${scripts[@]}"; do
    if [ -x "$script" ]; then
        echo "Running $script..."
        ./"$script"
    else
        echo "Warning: $script is not executable or does not exist!"
    fi
done

echo "All setup scripts completed."
