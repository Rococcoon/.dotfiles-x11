#!/bin/bash

# Set the target directory for installation
LSP_DIR="$HOME/.local/share/lsp"
HTML_LSP_DIR="$LSP_DIR/vscode-language-server"
BIN_DIR="$HTML_LSP_DIR/bin"
HTML_LSP_PACKAGE="vscode-langservers-extracted"

# Ensure the directories exist
mkdir -p "$HTML_LSP_DIR"

# Function to get the installed version of the language server
get_installed_version() {
  if [ -f "$HTML_LSP_DIR/node_modules/$HTML_LSP_PACKAGE/package.json" ]; then
    cat "$HTML_LSP_DIR/node_modules/$HTML_LSP_PACKAGE/package.json" | grep '"version"' | head -1 | awk -F '"' '{print $4}'
  else
    echo "none"
  fi
}

# Function to get the latest version of the package from npm
get_latest_version() {
  npm show "$HTML_LSP_PACKAGE" version
}

# Check if npm is installed
if ! command -v npm &> /dev/null; then
  echo "npm is not installed. Please install npm to continue."
  exit 1
fi

# Get installed and latest versions
INSTALLED_VERSION=$(get_installed_version)
LATEST_VERSION=$(get_latest_version)

# Compare versions
if [ "$INSTALLED_VERSION" == "$LATEST_VERSION" ]; then
  echo "HTML Language Server is up to date (version $INSTALLED_VERSION). No update needed."
  exit 0
else
  if [ "$INSTALLED_VERSION" == "none" ]; then
    echo "HTML Language Server is not installed. Proceeding with installation..."
  else
    echo "Updating HTML Language Server from version $INSTALLED_VERSION to $LATEST_VERSION..."
  fi
fi

# Install/update the HTML language server
echo "Installing HTML Language Server..."
npm install --prefix "$HTML_LSP_DIR" "$HTML_LSP_PACKAGE"

# Check if installation succeeded
if [ ! -f "$BIN_DIR/html-languageserver.js" ]; then
  echo "Installation failed. Could not find HTML Language Server."
  exit 1
fi

echo "HTML Language Server installed successfully in $HTML_LSP_DIR"

# Create a symbolic link to the executable in ~/.local/bin if you want easier access
if [ ! -d "$HOME/.local/bin" ]; then
  mkdir -p "$HOME/.local/bin"
fi
ln -sf "$BIN_DIR/html-languageserver" "$HOME/.local/bin/html-languageserver"

echo "Installation complete. You can now run the server with 'html-languageserver'."
