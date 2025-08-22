#!/bin/bash
set -e

TERRAFORM_DIR="$(dirname "$0")"
APP_DIR="${TERRAFORM_DIR}/../app"
IMAGE_NAME="myapp:latest"

# Build the Docker image in app directory
cd app
docker buildx build --platform linux/amd64 -t realworldacr.azurecr.io/realworld-django:latest .

# Push the Docker image to Azure Container Registry                    
az acr login --name realworldacr
docker push realworldacr.azurecr.io/realworld-django:latest   



# in terraform directory
# SSH into the VM
az network bastion ssh \
  --name managed-bastion \
  --resource-group realworld-rg \
  --target-resource-id /subscriptions/21d650d4-1f79-425e-9931-87fbd60eb2ba/resourceGroups/realworld-rg/providers/Microsoft.Compute/virtualMachines/backend-vm \
  --auth-type ssh-key \
  --username azureuser \
  --ssh-key ./keys/azure_id_rsa


# Install Docker + Azure CLI

# Update and install prerequisites
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release

# Add Docker’s official GPG key
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up the stable repo
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Start Docker
sudo systemctl enable docker
sudo systemctl start docker

# Add your user to the docker group
sudo usermod -aG docker azureuser

# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Install postgres client
sudo apt install postgresql-client -y

# Rstart SSH for group change to take effect exit 

# Login to Azure Container Registry
az login --identity
az acr login --name realworldacr

# Get access
{
  "environmentName": "AzureCloud",
  "homeTenantId": "a68b2696-4098-4a54-b6e8-b83706b1b561",
  "id": "21d650d4-1f79-425e-9931-87fbd60eb2ba",
  "isDefault": true,
  "managedByTenants": [],
  "name": "Azure subscription 1",
  "state": "Enabled",
  "tenantId": "a68b2696-4098-4a54-b6e8-b83706b1b561",
  "user": {
    "assignedIdentityInfo": "MSI",
    "name": "systemAssignedIdentity",
    "type": "servicePrincipal"
  }
# Get access token for PostgreSQL
export ACCESS_TOKEN=$(az account get-access-token --resource https://ossrdbms-aad.database.windows.net --query accessToken -o tsv)
#eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IkpZaE
# Pull the latest image from Azure Container Registry
docker pull realworldacr.azurecr.io/realworld-django:latest

# Run 
docker run -d -p 8000:8000 --name realworld-django realworldacr.azurecr.io/realworld-django:latest

# test 
curl -i http://10.0.2.4:8000/health/
curl -i http://10.0.2.4:8000/swagger/

#In browser http://74.248.136.149/health/