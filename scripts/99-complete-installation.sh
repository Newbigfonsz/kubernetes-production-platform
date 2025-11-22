#!/bin/bash
set -e

echo "╔═══════════════════════════════════════════╗"
echo "║                                           ║"
echo "║   Kubernetes Platform Installation 🚀     ║"
echo "║                                           ║"
echo "╚═══════════════════════════════════════════╝"
echo ""

# Check if running on master
if [ "$(hostname)" != "k3s-master" ]; then
  echo "⚠️  This script should run on k3s-master"
  exit 1
fi

# Verify nodes are ready
echo "Checking cluster status..."
if ! kubectl get nodes &>/dev/null; then
  echo "❌ Kubernetes cluster not accessible"
  echo "Run: ./scripts/01-install-k3s-master.sh first"
  exit 1
fi

NODE_COUNT=$(kubectl get nodes --no-headers | wc -l)
echo "✅ Found $NODE_COUNT nodes"

# Install components
echo ""
echo "Installing components..."

echo "📊 Installing Monitoring Stack..."
./scripts/03-install-monitoring.sh

echo "📝 Installing Logging Stack..."
./scripts/04-install-logging.sh

echo "🔄 Installing ArgoCD..."
./scripts/05-install-argocd.sh

echo "💾 Installing Backup Solution..."
./scripts/06-install-backup.sh

echo "🔒 Applying Security Hardening..."
./scripts/07-install-security.sh

echo "🎯 Installing Advanced Features..."
./scripts/08-install-advanced.sh

echo ""
echo "╔═══════════════════════════════════════════╗"
echo "║                                           ║"
echo "║   ✅ INSTALLATION COMPLETE! 🎉            ║"
echo "║                                           ║"
echo "╚═══════════════════════════════════════════╝"
echo ""

echo "Access your services:"
echo "  ArgoCD:     http://192.168.1.201:32012"
echo "  Grafana:    http://192.168.1.201:30300"
echo "  Prometheus: http://192.168.1.201:30090"
echo "  MinIO:      http://192.168.1.201:30900"
echo ""

echo "For credentials, see: docs/03-access-guide.md"
