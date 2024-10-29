#!/bin/bash

# Exit script if any command fails
set -e

# MongoDB container details
MONGO_CONTAINER_NAME="mongodb"

# Check if the MongoDB container exists
if docker ps -a --format '{{.Names}}' | grep -q "^$MONGO_CONTAINER_NAME$"; then
  echo "Stopping and removing MongoDB container..."
  docker stop $MONGO_CONTAINER_NAME && docker rm $MONGO_CONTAINER_NAME
  echo "MongoDB container stopped and removed."
else
  echo "No MongoDB container found."
fi
