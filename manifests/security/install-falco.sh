#!/bin/bash

echo "╔═══════════════════════════════════════════╗"
echo "║         Installing Falco                  ║"
echo "╚═══════════════════════════════════════════╝"

# Add Falco repo
helm repo add falcosecurity https://falcosecurity.github.io/charts
helm repo update

# Install Falco
helm install falco falcosecurity/falco \
  --namespace falco \
  --create-namespace \
  --set tty=true \
  --set falco.grpc.enabled=true \
  --set falco.grpcOutput.enabled=true \
  --set falco.json_output=true

sleep 45

kubectl get pods -n falco

echo ""
echo "✅ Falco installed!"
echo ""
echo "Runtime security alerts for:"
echo "  🚨 Shell spawned in container"
echo "  🚨 Sensitive file access"
echo "  🚨 Network connections"
echo "  🚨 Privilege escalation"
echo ""
echo "View alerts:"
echo "  kubectl logs -f -n falco -l app.kubernetes.io/name=falco"
