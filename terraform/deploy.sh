#!/bin/bash
set -e


# Build the Docker image in app directory
cd app
docker buildx build --platform linux/amd64 -t realworldacr.azurecr.io/realworld-django:latest .

# Push the Docker image to Azure Container Registry
az login --identity --username "$(terraform output -raw vm_principal_id)"                        
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



# Pull the latest image from Azure Container Registry
docker pull realworldacr.azurecr.io/realworld-django:latest

# Run 
docker run -d -p 8000:8000 --name realworld-django realworldacr.azurecr.io/realworld-django:latest

# test 
curl -i http://10.0.2.4:8000/health/
curl -i http://10.0.2.4:8000/swagger/

#In browser http://74.248.136.149/health/