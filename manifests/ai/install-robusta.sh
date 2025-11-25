#!/bin/bash

echo "╔═══════════════════════════════════════════╗"
echo "║       Installing Robusta                  ║"
echo "╚═══════════════════════════════════════════╝"

# Add Robusta repo
helm repo add robusta https://robusta-charts.storage.googleapis.com
helm repo update

# Install Robusta
helm install robusta robusta/robusta \
  --namespace robusta \
  --create-namespace \
  --set clusterName=production-cluster \
  --set disableCloudRouting=true

sleep 30

kubectl get pods -n robusta

echo ""
echo "✅ Robusta installed!"
echo ""
echo "Features:"
echo "  🤖 AI-powered troubleshooting"
echo "  🔍 Automatic root cause analysis"
echo "  📊 Smart alerts"
