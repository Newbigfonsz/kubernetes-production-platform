#!/bin/bash

echo "╔═══════════════════════════════════════════╗"
echo "║    INSTALLING ULTIMATE FEATURES! 🔥       ║"
echo "╚═══════════════════════════════════════════╝"
echo ""
echo "This will take ~10 minutes..."
echo ""

# 1. Cert-Manager
echo "1️⃣  Installing Cert-Manager (SSL)..."
./manifests/cert-manager/install-cert-manager.sh

# 2. Sealed Secrets
echo ""
echo "2️⃣  Installing Sealed Secrets..."
./manifests/security/install-sealed-secrets.sh

# 3. Reloader
echo ""
echo "3️⃣  Installing Reloader..."
kubectl apply -f manifests/advanced/reloader.yaml
sleep 20

# 4. KEDA
echo ""
echo "4️⃣  Installing KEDA (Event-driven autoscaling)..."
./manifests/autoscaling/install-keda.sh

# 5. Falco
echo ""
echo "5️⃣  Installing Falco (Runtime security)..."
./manifests/security/install-falco.sh

# 6. Goldpinger
echo ""
echo "6️⃣  Installing Goldpinger (Network monitoring)..."
kubectl apply -f manifests/monitoring/goldpinger.yaml
sleep 30

# 7. K9s
echo ""
echo "7️⃣  Installing K9s (Terminal UI)..."
~/install-k9s.sh

echo ""
echo "╔═══════════════════════════════════════════╗"
echo "║      ✅ ULTIMATE FEATURES INSTALLED! ✅   ║"
echo "╚═══════════════════════════════════════════╝"
echo ""
echo "New Capabilities:"
echo "  🔒 Cert-Manager: Automatic SSL certificates"
echo "  🔐 Sealed Secrets: Secure secret management"
echo "  🔄 Reloader: Auto-restart on config changes"
echo "  ⚡ KEDA: Event-driven autoscaling"
echo "  🚨 Falco: Runtime security monitoring"
echo "  📡 Goldpinger: Network health visualization"
echo "  💻 K9s: Beautiful terminal UI"
echo ""
echo "Access URLs:"
echo "  📡 Goldpinger: http://192.168.1.201:30910"
echo ""
echo "Terminal Commands:"
echo "  k9s              - Launch K9s UI"
echo "  kubeseal --help  - Seal secrets"
echo ""
echo "View Security Alerts:"
echo "  kubectl logs -f -n falco -l app.kubernetes.io/name=falco"
echo ""
echo "Run Security Scan:"
echo "  ./manifests/security/run-kube-bench.sh"
