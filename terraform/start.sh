#!/bin/bash
set -e

# ---- Load updated .env values ----
set -a
# shellcheck disable=SC1091
source "./.env"
set +a


# ---- Export TF_VARs for Terraform ----
export TF_VAR_subscription_id="$ARM_SUBSCRIPTION_ID"
TF_VAR_ssh_public_key="$(cat ./keys/azure_id_rsa.pub)"
export TF_VAR_ssh_public_key

terraform fmt
terraform validate
terraform plan
terraform apply