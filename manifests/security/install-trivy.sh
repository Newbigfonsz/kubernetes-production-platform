#!/bin/bash

echo "╔═══════════════════════════════════════════╗"
echo "║       Installing Trivy Operator           ║"
echo "╚═══════════════════════════════════════════╝"

# Add Aqua repo
helm repo add aqua https://aquasecurity.github.io/helm-charts/
helm repo update

# Install Trivy Operator
helm install trivy-operator aqua/trivy-operator \
  --namespace trivy-system \
  --create-namespace \
  --set="trivy.ignoreUnfixed=true"

sleep 30

kubectl get pods -n trivy-system

echo ""
echo "✅ Trivy Operator installed!"
echo ""
echo "View vulnerability reports:"
echo "  kubectl get vulnerabilityreports --all-namespaces"
echo ""
echo "View config audit reports:"
echo "  kubectl get configauditreports --all-namespaces"
echo ""
echo "Trivy scans:"
echo "  🔍 Container images for CVEs"
echo "  ⚙️  Kubernetes configs"
echo "  🔐 Secrets scanning"
echo "  📜 RBAC issues"
