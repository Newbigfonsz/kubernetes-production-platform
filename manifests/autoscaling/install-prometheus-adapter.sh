#!/bin/bash

echo "╔═══════════════════════════════════════════╗"
echo "║       Installing Prometheus Adapter       ║"
echo "╚═══════════════════════════════════════════╝"

# Install Prometheus Adapter
helm install prometheus-adapter prometheus-community/prometheus-adapter \
  --namespace monitoring \
  --set prometheus.url=http://prometheus-kube-prometheus-prometheus.monitoring.svc \
  --set prometheus.port=9090

sleep 30

kubectl get pods -n monitoring | grep adapter

echo ""
echo "✅ Prometheus Adapter installed!"
echo ""
echo "Now you can autoscale on ANY custom metric!"
