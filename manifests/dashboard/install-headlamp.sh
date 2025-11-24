#!/bin/bash

echo "╔═══════════════════════════════════════════╗"
echo "║       Installing Headlamp                 ║"
echo "╚═══════════════════════════════════════════╝"

# Add Headlamp repo
helm repo add headlamp https://headlamp-k8s.github.io/headlamp/
helm repo update

# Install Headlamp
helm install headlamp headlamp/headlamp \
  --namespace headlamp \
  --create-namespace \
  --set service.type=NodePort \
  --set service.nodePort=30930

sleep 30

kubectl get pods -n headlamp

# Create service account and token
kubectl create serviceaccount headlamp-admin -n headlamp
kubectl create clusterrolebinding headlamp-admin \
  --clusterrole=cluster-admin \
  --serviceaccount=headlamp:headlamp-admin

echo ""
echo "✅ Headlamp installed!"
echo ""
echo "🌐 Access: http://192.168.1.201:30930"
echo ""
echo "Get token:"
echo "  kubectl create token headlamp-admin -n headlamp"
echo ""
echo "Features:"
echo "  🎨 Beautiful modern UI"
echo "  📊 Real-time updates"
echo "  📝 Built-in log viewer"
echo "  ⚡ Fast and responsive"
