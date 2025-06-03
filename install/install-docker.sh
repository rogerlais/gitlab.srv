#!/bin/bash
# Script to install Docker on Debian 12

# Exit immediately if a command exits with a non-zero status
set -e

# Check if script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Error: This script must be run as root" >&2
    echo "Please run with sudo or as root user"
    exit 1
fi

# Check if Docker is already installed
if command -v docker &> /dev/null; then
    echo "Docker is already installed."
    docker --version
    echo "Exiting..."
    exit 0
fi

echo "Installing Docker on Debian 12..."

# Update package list and install prerequisites
echo "Installing prerequisites..."
apt-get update
apt-get install -y ca-certificates curl gnupg

# Add Docker's official GPG key
echo "Adding Docker's official GPG key..."
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# Add Docker repository
echo "Setting up Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update apt package index
apt-get update

# Install Docker Engine and related packages
echo "Installing Docker Engine and related packages..."
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Get the username of the user who invoked sudo (if sudo was used)
ACTUAL_USER=${SUDO_USER:-$USER}
if [ "$ACTUAL_USER" != "root" ]; then
    echo "Adding user $ACTUAL_USER to the docker group..."
    usermod -aG docker $ACTUAL_USER
    echo "NOTE: You need to log out and log back in for the group changes to take effect."
fi

# Start and enable Docker service
echo "Starting and enabling Docker service..."
systemctl enable docker
systemctl start docker

# Verify installation
echo "Verifying installation..."
docker --version
docker run --rm hello-world

echo "Docker installation completed successfully!"