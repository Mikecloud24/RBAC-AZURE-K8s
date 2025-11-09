#!/bin/bash
#
# Check restart-related permissions (delete/patch/update) per namespace
# Usage:
#   ./check-restart-perms-ns.sh --user ops-user@example.com
#

set -euo pipefail

# Default user (if none provided)
USER=""

# Parse flags
while [[ $# -gt 0 ]]; do
  case $1 in
    --user|-u)
      USER="$2"
      shift 2
      ;;
    --help|-h)
      echo "Usage: $0 --user <user@example.com>"
      echo
      echo "Checks if the specified Kubernetes user has permissions to restart workloads"
      echo "(delete pods, patch/update deployments, patch statefulsets/daemonsets) per namespace."
      exit 0
      ;;
    *)
      echo "Unknown argument: $1"
      echo "Use --help for usage information."
      exit 1
      ;;
  esac
done

# Validate user input
if [[ -z "$USER" ]]; then
  echo "Error: No user specified."
  echo "Usage: $0 --user <user@example.com>"
  exit 1
fi

# Get namespaces
NAMESPACES=$(kubectl get ns -o jsonpath='{.items[*].metadata.name}')

echo "Checking restart-related permissions for user: $USER"
echo "-----------------------------------------------------------"
echo

# Loop through namespaces
for ns in $NAMESPACES; do
  echo "Namespace: $ns"

  POD_DELETE=$(kubectl auth can-i delete pods --as=$USER -n $ns)
  DEPLOY_PATCH=$(kubectl auth can-i patch deployments --as=$USER -n $ns)
  DEPLOY_UPDATE=$(kubectl auth can-i update deployments --as=$USER -n $ns)
  STS_PATCH=$(kubectl auth can-i patch statefulsets --as=$USER -n $ns)
  DS_PATCH=$(kubectl auth can-i patch daemonsets --as=$USER -n $ns)

  printf "Delete pods: %s\n" "$( [[ $POD_DELETE == "yes" ]] && echo 'yes' || echo 'no' )"
  printf "Patch deployments: %s\n" "$( [[ $DEPLOY_PATCH == "yes" ]] && echo 'yes' || echo 'no' )"
  printf "Update deployments: %s\n" "$( [[ $DEPLOY_UPDATE == "yes" ]] && echo 'yes' || echo 'no' )"
  printf "Patch statefulsets: %s\n" "$( [[ $STS_PATCH == "yes" ]] && echo 'yes' || echo 'no' )"
  printf "Patch daemonsets: %s\n" "$( [[ $DS_PATCH == "yes" ]] && echo 'yes' || echo 'no' )"
  echo
done

echo "Permission check complete."
