#!/bin/bash

echo "╔═══════════════════════════════════════════╗"
echo "║       Installing Kyverno                  ║"
echo "╚═══════════════════════════════════════════╝"

# Add Kyverno repo
helm repo add kyverno https://kyverno.github.io/kyverno/
helm repo update

# Install Kyverno
helm install kyverno kyverno/kyverno \
  --namespace kyverno \
  --create-namespace \
  --set replicaCount=3

sleep 30

kubectl get pods -n kyverno

echo ""
echo "✅ Kyverno installed!"
echo ""
echo "View policies:"
echo "  kubectl get clusterpolicy"
