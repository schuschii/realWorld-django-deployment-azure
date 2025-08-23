#!/bin/bash
set -e

# In app directory
cd "$(dirname "$0")/../app"

az login --identity

# Push the Docker image to Azure Container Registry         
# docker buildx build --platform linux/amd64 -t realworldacr.azurecr.io/realworld-django:latest .           
az acr login --name realworldacr
docker push realworldacr.azurecr.io/realworld-django:latest   


#SSH into the postgres VM using Bastion
az network bastion ssh \
  --name managed-bastion \
  --resource-group realworld-rg \
  --target-resource-id /subscriptions/21d650d4-1f79-425e-9931-87fbd60eb2ba/resourceGroups/realworld-rg/providers/Microsoft.Compute/virtualMachines/postgres-vm \
  --auth-type ssh-key \
  --username postgresuser \
  --ssh-key ./keys/azure_id_rsa






# SSH into the VM
az network bastion ssh \
  --name managed-bastion \
  --resource-group realworld-rg \
  --target-resource-id /subscriptions/21d650d4-1f79-425e-9931-87fbd60eb2ba/resourceGroups/realworld-rg/providers/Microsoft.Compute/virtualMachines/backend-vm \
  --auth-type ssh-key \
  --username azureuser \
  --ssh-key ./keys/azure_id_rsa


# Pull the latest image from Azure Container Registry
az acr login --name realworldacr
docker pull realworldacr.azurecr.io/realworld-django:latest

# Run 
docker run -d -p 8000:8000 --name realworld-django realworldacr.azurecr.io/realworld-django:latest

# test 
curl -i http://10.0.2.4:8000/health/
curl -i http://10.0.2.4:8000/swagger/

#In browser http://74.248.136.149/health/