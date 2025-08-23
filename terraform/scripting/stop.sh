#!/bin/bash
set -e

# Always work from terraform root (parent of scripting/)
cd "$(dirname "$0")/.."

set -a
# shellcheck disable=SC1091
source "./.env"
set +a

TF_VAR_ssh_public_key="$(cat ./keys/azure_id_rsa.pub)"
export TF_VAR_ssh_public_key

terraform destroy 