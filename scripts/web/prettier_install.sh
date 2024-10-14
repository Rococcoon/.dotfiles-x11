#!/bin/bash

# Check if Prettier is already installed
if command -v prettier &> /dev/null; then
  echo "Prettier is already installed. Checking for updates..."
  
  # Update Prettier using webi
  webi prettier
else
  echo "Prettier is not installed. Installing now..."
  
  # Install Prettier using webi
  webi prettier
fi

echo "Prettier installation or update complete."
