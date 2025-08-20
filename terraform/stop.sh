#!/bin/bash
set -e

set -a
# shellcheck disable=SC1091
source "./.env"
set +a

TF_VAR_ssh_public_key="$(cat ./keys/azure_id_rsa.pub)"
export TF_VAR_ssh_public_key

terraform destroy 