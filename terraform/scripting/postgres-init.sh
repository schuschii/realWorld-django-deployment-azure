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
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Start Docker
sudo systemctl enable docker
sudo systemctl start docker

# Add your users to docker group
sudo usermod -aG docker postgresuser || true

# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Install postgres client
sudo apt-get install -y postgresql-client

APP_DIR="/home/postgresuser/app"
sudo mkdir -p "$APP_DIR"
sudo chown postgresuser:postgresuser "$APP_DIR"

cat <<EOF > $APP_DIR/docker-compose.yml
version: "3.9"
services:
  db:
    image: postgres:latest
    restart: always
    ports:
      - "5432:5432"
    volumes:
      - db-data:/var/lib/postgresql/data
    environment:
      - POSTGRES_USER=app_user
      - POSTGRES_PASSWORD=SecureAppPassword123!
      - POSTGRES_DB=postgres
volumes:
  db-data:
EOF

sudo docker compose -f $APP_DIR/docker-compose.yml up -d

# Reboot to apply group membership changes
sudo reboot