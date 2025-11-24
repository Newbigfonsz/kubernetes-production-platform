#!/bin/bash

echo "╔═══════════════════════════════════════════╗"
echo "║       Installing Kubecost                 ║"
echo "╚═══════════════════════════════════════════╝"

# Add Kubecost Helm repo
helm repo add kubecost https://kubecost.github.io/cost-analyzer/
helm repo update

# Install Kubecost
helm install kubecost kubecost/cost-analyzer \
  --namespace kubecost \
  --create-namespace \
  --set kubecostToken="aGVsbUBrdWJlY29zdC5jb20=xm343yadf98" \
  --set prometheus.server.global.external_labels.cluster_id=home-k3s \
  --set prometheus.nodeExporter.enabled=false \
  --set prometheus.serviceAccounts.nodeExporter.create=false \
  --set ingress.enabled=false \
  --set persistentVolume.enabled=true \
  --set persistentVolume.size=10Gi

echo "Waiting for Kubecost (60 seconds)..."
sleep 60

# Expose with NodePort
kubectl patch svc kubecost-cost-analyzer -n kubecost \
  --type='json' \
  -p='[{"op":"replace","path":"/spec/type","value":"NodePort"},
       {"op":"add","path":"/spec/ports/0/nodePort","value":30900}]'

echo ""
echo "✅ Kubecost installed!"
echo ""
echo "Access at: http://192.168.1.201:30900"
echo ""
echo "Features:"
echo "  💰 Cost per namespace"
echo "  📊 Resource efficiency scores"
echo "  📈 Cost trends and forecasts"
echo "  💡 Savings recommendations"
