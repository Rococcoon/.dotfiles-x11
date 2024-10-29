#!/bin/bash

# Exit script if any command fails
set -e

# MongoDB container details
MONGO_CONTAINER_NAME="mongodb"
MONGO_IMAGE="mongo:latest"
MONGO_PORT=27017  # Default MongoDB port
MONGO_DATA_PATH="$HOME/mongo_data"  # Path to store MongoDB data

# Function to install MongoDB using Docker
install_mongo() {
  echo "Creating MongoDB data directory at $MONGO_DATA_PATH..."
  mkdir -p "$MONGO_DATA_PATH"

  echo "Pulling the MongoDB Docker image..."
  docker pull $MONGO_IMAGE

  echo "Starting MongoDB container..."
  docker run -d \
    --name $MONGO_CONTAINER_NAME \
    -p $MONGO_PORT:27017 \
    -v $MONGO_DATA_PATH:/data/db \
    --restart unless-stopped \
    $MONGO_IMAGE

  echo "MongoDB installation and container setup completed."
}

# Function to update MongoDB Docker image and container
update_mongo() {
  echo "Stopping MongoDB container..."
  docker stop $MONGO_CONTAINER_NAME

  echo "Removing the old MongoDB container..."
  docker rm $MONGO_CONTAINER_NAME

  echo "Pulling the latest MongoDB Docker image..."
  docker pull $MONGO_IMAGE

  echo "Starting a new MongoDB container with the latest image..."
  docker run -d \
    --name $MONGO_CONTAINER_NAME \
    -p $MONGO_PORT:27017 \
    -v $MONGO_DATA_PATH:/data/db \
    --restart unless-stopped \
    $MONGO_IMAGE

  echo "MongoDB container updated successfully."
}

# Wait for MongoDB to be ready
wait_for_mongo() {
  echo "Waiting for MongoDB to start..."
  while ! docker exec $MONGO_CONTAINER_NAME mongosh --eval "db.stats()" &>/dev/null; do
    echo -n "."
    sleep 2
  done
  echo "MongoDB is ready to accept connections."
}

# Main script logic
echo "Checking for existing MongoDB container..."

if ! docker ps -a --format '{{.Names}}' | grep -q "^$MONGO_CONTAINER_NAME$"; then
  echo "MongoDB container not found. Starting installation..."
  install_mongo
else
  echo "MongoDB container found. Updating MongoDB..."
  update_mongo
fi

# Wait for MongoDB to be ready before testing the connection
wait_for_mongo

# Test MongoDB connection
echo "Testing MongoDB connection..."
docker exec -it $MONGO_CONTAINER_NAME mongosh --eval "db.stats()"

echo "MongoDB setup and update completed successfully."
