#!/bin/bash

echo "╔═══════════════════════════════════════════╗"
echo "║     Installing More Awesome Features      ║"
echo "╚═══════════════════════════════════════════╝"
echo ""

# 1. Kubernetes Dashboard
echo "1️⃣  Installing Kubernetes Dashboard..."
./manifests/dashboard/install-dashboard.sh

# 2. Kube-State-Metrics
echo ""
echo "2️⃣  Installing Kube-State-Metrics..."
kubectl apply -f manifests/monitoring/kube-state-metrics.yaml
sleep 30

# 3. Configure Loki
echo ""
echo "3️⃣  Configuring Loki datasource..."
./manifests/monitoring/configure-loki-datasource.sh

# 4. Ingress NGINX
echo ""
echo "4️⃣  Installing Ingress NGINX..."
./manifests/ingress/install-ingress.sh

# 5. Load Generator
echo ""
echo "5️⃣  Installing Load Generator..."
kubectl apply -f manifests/demos/load-generator.yaml

echo ""
echo "╔═══════════════════════════════════════════╗"
echo "║        ✅ ALL FEATURES INSTALLED! ✅      ║"
echo "╚═══════════════════════════════════════════╝"
echo ""
echo "New Features:"
echo "  🖥️  Kubernetes Dashboard: https://192.168.1.201:30443"
echo "  📊 Kube-State-Metrics: Enhanced Prometheus metrics"
echo "  📝 Loki in Grafana: View logs in dashboards"
echo "  🌐 Ingress NGINX: Production routing"
echo "  🎮 Load Generator: Auto stress testing"
echo ""
echo "Get Dashboard Token:"
echo "  kubectl -n kubernetes-dashboard create token admin-user"
echo ""
echo "Watch Autoscaling:"
echo "  watch kubectl get hpa -n todoapp"
echo ""
echo "View Load Generator Logs:"
echo "  kubectl logs -f -n demo -l app=load-generator"
