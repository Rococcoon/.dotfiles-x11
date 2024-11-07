#!/bin/bash

# Exit script if any command fails
set -e

# Function to install Docker
install_docker() {
  echo "Updating package index..."
  sudo apt update

  echo "Installing prerequisites..."
  sudo apt install -y ca-certificates curl gnupg

  echo "Adding Docker’s official GPG key..."
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

  echo "Adding Docker repository..."
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  echo "Updating package index again..."
  sudo apt update

  echo "Installing Docker Engine, CLI, and Compose..."
  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  echo "Docker installation completed."
}

# Function to update Docker
update_docker() {
  echo "Updating Docker packages..."
  sudo apt update
  sudo apt install --only-upgrade -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  echo "Docker updated successfully."
}

# Function to add the user to the Docker group
add_user_to_docker_group() {
  echo "Creating Docker group if it does not exist..."
  sudo groupadd -f docker

  echo "Adding current user to the Docker group..."
  sudo usermod -aG docker "$USER"

  echo "Activating Docker group without log-out..."
  newgrp docker <<EONG
    echo "Docker group activated for this session."
    docker --version
    docker run hello-world
EONG
}

# Function to install standalone Docker Compose (if desired)
install_standalone_docker_compose() {
  echo "Installing standalone Docker Compose..."

  # Download the latest version of Docker Compose
  sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

  # Make Docker Compose executable
  sudo chmod +x /usr/local/bin/docker-compose

  # Verify installation
  docker-compose --version
  echo "Standalone Docker Compose installed successfully."
}

# Main script logic
echo "Checking for Docker installation..."

if ! command -v docker &> /dev/null; then
  echo "Docker not found. Starting installation..."
  install_docker
  add_user_to_docker_group
else
  echo "Docker is already installed. Updating Docker..."
  update_docker
fi

# Check if standalone Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
  echo "Docker Compose (standalone) not found. Installing standalone Docker Compose..."
  install_standalone_docker_compose
else
  echo "Docker Compose (standalone) is already installed."
fi

echo "Docker setup and update completed successfully."
