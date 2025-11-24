#!/bin/bash

echo "╔═══════════════════════════════════════════╗"
echo "║    Installing Kubernetes Dashboard        ║"
echo "╚═══════════════════════════════════════════╝"

# Install Kubernetes Dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml

# Create admin user
cat <<EOADMIN | kubectl apply -f -
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
EOADMIN

sleep 30

# Expose with NodePort
kubectl patch svc kubernetes-dashboard -n kubernetes-dashboard \
  --type='json' \
  -p='[{"op":"replace","path":"/spec/type","value":"NodePort"},
       {"op":"add","path":"/spec/ports/0/nodePort","value":30443}]'

echo ""
echo "✅ Kubernetes Dashboard installed!"
echo ""
echo "Access: https://192.168.1.201:30443"
echo ""
echo "Get login token:"
echo "kubectl -n kubernetes-dashboard create token admin-user"
echo ""
echo "Features:"
echo "  📊 Visual cluster overview"
echo "  📝 Pod logs in browser"
echo "  ⚙️  Resource management"
echo "  🔍 Event viewer"
