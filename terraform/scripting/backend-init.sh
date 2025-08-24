#!/bin/bash
# Update and install prerequisites
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl gnupg lsb-release

# Add Docker’s official GPG key
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up the stable repo
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Start Docker
sudo systemctl enable docker
sudo systemctl start docker

# Add your users to docker group
sudo usermod -aG docker azureuser || true

# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Install postgres client
sudo apt-get install -y postgresql-client
 
# Ensure .env is not a directory
if [ -d /home/azureuser/.env ]; then
    sudo rm -rf /home/azureuser/.env
fi

# Create .env with SECRET_KEY if missing
if [ ! -f /home/azureuser/.env ]; then
    echo "SECRET_KEY=$(openssl rand -base64 32)" | sudo tee /home/azureuser/.env > /dev/null
fi

# Set ownership and permissions
sudo chown azureuser:azureuser /home/azureuser/.env
sudo chmod 600 /home/azureuser/.env

# Reboot to apply group membership changes
sudo reboot