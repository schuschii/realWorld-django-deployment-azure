#!/bin/bash
set -e

# Load .env
set -a
# shellcheck disable=SC1091
source "./.env"
set +a


bash generate_key.sh

if [ -z "$ARM_SUBSCRIPTION_ID" ]; then
  echo "SUBSCRIPTION ID is empty. Check your .env!"
  exit 1
fi

SP_NAME="terraform-sp"

# Check if SP already exists
SP_APP_ID=$(az ad sp list --display-name "$SP_NAME" --query "[0].appId" -o tsv)

if [ -n "$SP_APP_ID" ]; then
  echo "Service Principal '$SP_NAME' already exists (App ID: $SP_APP_ID)."
  echo "No new credentials created. If you need a new secret, run:"
  echo "az ad sp credential reset --id $SP_APP_ID"

else
  echo "Creating new Service Principal '$SP_NAME'..."
  SP_OUTPUT=$(az ad sp create-for-rbac \
      --name "$SP_NAME" \
      --role "User Access Administrator" \
      --scopes "/subscriptions/$ARM_SUBSCRIPTION_ID" \
      --sdk-auth)
  
  echo "Service Principal created successfully."
  echo "$SP_OUTPUT"
  echo "Copy the values above into your .env (ARM_CLIENT_ID, ARM_CLIENT_SECRET, etc.)"
fi


terraform init