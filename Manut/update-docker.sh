#!/bin/bash
# Script to update Docker on Debian 12 (Bookworm)
# Usage: sudo ./update-docker.sh

set -e  # Exit immediately if a command exits with non-zero status

# Check if running with root privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root or with sudo privileges."
    exit 1
fi

# Check if Docker is installed
if ! command -v docker &>/dev/null; then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi

echo "Starting Docker update process..."

# Store current Docker version for comparison
CURRENT_VERSION=$(docker --version | cut -d ' ' -f 3 | tr -d ',')

# Update system packages
echo "Updating package lists..."
apt update

echo "Updating Docker packages..."
apt upgrade -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Check if a restart is needed
echo "Checking if Docker service restart is required..."
if systemctl list-units --state=running | grep -q docker; then
    echo "Docker service is running."
    read -p "Do you want to restart Docker service to apply updates? (y/N): " restart_choice
    if [[ "$restart_choice" =~ ^[Yy]$ ]]; then
        echo "Restarting Docker service..."
        systemctl restart docker
        echo "Docker service restarted successfully."
    else
        echo "Skipping Docker service restart."
    fi
fi

# Display updated Docker version
NEW_VERSION=$(docker --version | cut -d ' ' -f 3 | tr -d ',')
echo "Docker update completed."
echo "Docker version: $NEW_VERSION (was $CURRENT_VERSION)"
echo "Docker Compose version: $(docker compose version --short 2>/dev/null || echo 'not available')"
echo "Listing Docker images and containers..."
docker images
docker ps -a
echo "Listing Docker networks..."
docker network ls
echo "Listing Docker volumes..."
docker volume ls
echo "Docker update process completed successfully."