#!/bin/bash

echo "╔═══════════════════════════════════════════╗"
echo "║       Installing Linkerd Service Mesh     ║"
echo "╚═══════════════════════════════════════════╝"

# Install Linkerd CLI
curl --proto '=https' --tlsv1.2 -sSfL https://run.linkerd.io/install | sh
export PATH=$PATH:$HOME/.linkerd2/bin

# Pre-check
linkerd check --pre

# Install Linkerd CRDs
linkerd install --crds | kubectl apply -f -

# Install Linkerd control plane
linkerd install | kubectl apply -f -

echo "Waiting for Linkerd (60 seconds)..."
sleep 60

# Verify
linkerd check

# Install Viz extension (observability)
linkerd viz install | kubectl apply -f -

sleep 30

# Mesh the todoapp namespace
kubectl annotate namespace todoapp linkerd.io/inject=enabled

# Restart pods to inject sidecar
kubectl rollout restart deployment -n todoapp

echo ""
echo "✅ Linkerd Service Mesh installed!"
echo ""
echo "Access Linkerd Dashboard:"
echo "  linkerd viz dashboard &"
echo ""
echo "Features:"
echo "  🔒 Automatic mTLS between all services"
echo "  📊 Per-request metrics"
echo "  🎯 Traffic splitting (canary deployments)"
echo "  🔄 Automatic retries"
echo "  ⏱️  Timeouts"
echo "  📈 Success rate tracking"
echo ""
echo "View meshed services:"
echo "  linkerd viz stat deploy -n todoapp"
