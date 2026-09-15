#!/bin/bash
# post-install.sh
# Purpose: Post-provisioning steps after Terraform creates the clusters.
# Run this after terraform apply to log in and rename contexts.

set -euo pipefail

echo "=== Retrieving cluster credentials ==="

HUB_API=$(terraform output -raw hub_api_url)
SECURED_API=$(terraform output -raw secured_api_url)

echo "Hub API:     ${HUB_API}"
echo "Secured API: ${SECURED_API}"

echo ""
echo "=== Logging in to clusters ==="
echo "You will need the kubeadmin passwords from the ROSA console or 'rosa describe cluster'."
echo ""
echo "Run the following commands:"
echo ""
echo "  oc login --server=${HUB_API} --username=cluster-admin"
echo "  oc config rename-context \$(oc config current-context) hub"
echo ""
echo "  oc login --server=${SECURED_API} --username=cluster-admin"
echo "  oc config rename-context \$(oc config current-context) secured"
echo ""
echo "Then continue with the workshop setup: 00-setup.adoc"
