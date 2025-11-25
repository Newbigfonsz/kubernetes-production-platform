#!/bin/bash

echo "╔═══════════════════════════════════════════╗"
echo "║       Installing Chaos Mesh               ║"
echo "╚═══════════════════════════════════════════╝"

# Add Chaos Mesh repo
helm repo add chaos-mesh https://charts.chaos-mesh.org
helm repo update

# Install Chaos Mesh
helm install chaos-mesh chaos-mesh/chaos-mesh \
  --namespace chaos-mesh \
  --create-namespace \
  --set chaosDaemon.runtime=containerd \
  --set chaosDaemon.socketPath=/run/k3s/containerd/containerd.sock \
  --set dashboard.create=true \
  --set dashboard.service.type=NodePort \
  --set dashboard.service.nodePort=30950

sleep 60

kubectl get pods -n chaos-mesh

echo ""
echo "✅ Chaos Mesh installed!"
echo "🌐 Chaos Dashboard: http://192.168.1.201:30950"
