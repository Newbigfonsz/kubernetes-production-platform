#!/bin/bash

echo "╔═══════════════════════════════════════════╗"
echo "║    INSTALLING GOD-TIER FEATURES! 👑⚡     ║"
echo "╚═══════════════════════════════════════════╝"
echo ""

# 1. Chaos Mesh
echo "1️⃣  Installing Chaos Engineering..."
./manifests/chaos/install-chaos-mesh.sh

# 2. Kubescape
echo ""
echo "2️⃣  Installing Kubescape Security Scanner..."
./manifests/security/install-kubescape.sh

# 3. Argo Rollouts
echo ""
echo "3️⃣  Installing Argo Rollouts..."
./manifests/deployment/install-argo-rollouts.sh

# 4. Crossplane
echo ""
echo "4️⃣  Installing Crossplane..."
./manifests/infrastructure/install-crossplane.sh

# 5. Knative
echo ""
echo "5️⃣  Installing Knative Serverless..."
./manifests/serverless/install-knative.sh

echo ""
echo "╔═══════════════════════════════════════════╗"
echo "║      ✅ GOD-TIER STATUS ACHIEVED! ✅      ║"
echo "╚═══════════════════════════════════════════╝"
echo ""
echo "New Features:"
echo "  💥 Chaos Mesh: http://192.168.1.201:30950"
echo "  🛡️  Kubescape: Security scanning"
echo "  🎲 Argo Rollouts: Advanced deployments"
echo "  ☁️  Crossplane: Infrastructure as Code"
echo "  ⚡ Knative: Serverless functions"
echo ""
echo "Check installations:"
echo "  kubectl get pods -n chaos-mesh"
echo "  kubectl get pods -n kubescape"
echo "  kubectl get pods -n argo-rollouts"
echo "  kubectl get pods -n crossplane-system"
echo "  kubectl get pods -n knative-serving"
