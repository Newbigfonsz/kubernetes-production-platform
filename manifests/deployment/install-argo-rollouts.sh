#!/bin/bash

echo "╔═══════════════════════════════════════════╗"
echo "║       Installing Argo Rollouts            ║"
echo "╚═══════════════════════════════════════════╝"

# Install Argo Rollouts
kubectl create namespace argo-rollouts 2>/dev/null || true
kubectl apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml

sleep 30

# Install kubectl plugin
curl -LO https://github.com/argoproj/argo-rollouts/releases/latest/download/kubectl-argo-rollouts-linux-amd64
chmod +x kubectl-argo-rollouts-linux-amd64
sudo mv kubectl-argo-rollouts-linux-amd64 /usr/local/bin/kubectl-argo-rollouts

echo ""
echo "✅ Argo Rollouts installed!"
echo ""
echo "Use: kubectl argo rollouts list rollouts -A"
