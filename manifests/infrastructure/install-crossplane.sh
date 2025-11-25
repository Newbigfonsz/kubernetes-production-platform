#!/bin/bash

echo "╔═══════════════════════════════════════════╗"
echo "║       Installing Crossplane               ║"
echo "╚═══════════════════════════════════════════╝"

# Add Crossplane repo
helm repo add crossplane-stable https://charts.crossplane.io/stable
helm repo update

# Install Crossplane
helm install crossplane \
  crossplane-stable/crossplane \
  --namespace crossplane-system \
  --create-namespace

sleep 45

kubectl get pods -n crossplane-system

echo ""
echo "✅ Crossplane installed!"
