#!/bin/bash

echo "╔═══════════════════════════════════════════╗"
echo "║       Installing Kubescape                ║"
echo "╚═══════════════════════════════════════════╝"

# Install Kubescape CLI
curl -s https://raw.githubusercontent.com/kubescape/kubescape/master/install.sh | /bin/bash

# Move to PATH
sudo mv kubescape /usr/local/bin/ 2>/dev/null || true

# Install Kubescape operator
helm repo add kubescape https://kubescape.github.io/helm-charts/
helm repo update

helm install kubescape kubescape/kubescape-operator \
  --namespace kubescape \
  --create-namespace \
  --set capabilities.continuousScan=enable

sleep 30

kubectl get pods -n kubescape

echo ""
echo "✅ Kubescape installed!"
echo ""
echo "Run security scan:"
echo "  kubescape scan --verbose"
