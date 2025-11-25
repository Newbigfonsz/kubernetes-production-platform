#!/bin/bash

echo "╔═══════════════════════════════════════════╗"
echo "║       Enhancing Linkerd                   ║"
echo "╚═══════════════════════════════════════════╝"

# Install Linkerd Jaeger extension
linkerd jaeger install | kubectl apply -f -

sleep 30

# Expose Linkerd dashboard via NodePort
kubectl patch svc web -n linkerd-viz \
  --type='json' \
  -p='[{"op":"replace","path":"/spec/type","value":"NodePort"},
       {"op":"add","path":"/spec/ports/0/nodePort","value":31000}]' 2>/dev/null || echo "Service already exposed"

echo ""
echo "✅ Linkerd enhanced!"
echo ""
echo "🌐 Linkerd Dashboard: http://192.168.1.201:31000"
