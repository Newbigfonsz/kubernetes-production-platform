#!/bin/bash

echo "╔═══════════════════════════════════════════╗"
echo "║         Running Stress Test               ║"
echo "╚═══════════════════════════════════════════╝"
echo ""
echo "This will show your HPA in action!"
echo ""

# Delete old stress test if exists
kubectl delete pod stress-test -n todoapp 2>/dev/null

# Start stress test
kubectl apply -f manifests/testing/stress-test.yaml

echo ""
echo "📊 Watch the magic happen:"
echo ""
echo "Terminal 1 - Watch HPA:"
echo "  watch -n 2 'kubectl get hpa -n todoapp'"
echo ""
echo "Terminal 2 - Watch Pods:"
echo "  watch -n 2 'kubectl get pods -n todoapp'"
echo ""
echo "Terminal 3 - Watch CPU:"
echo "  watch -n 2 'kubectl top pods -n todoapp'"
echo ""
echo "You should see:"
echo "  🔥 CPU usage increase"
echo "  📈 HPA start scaling up"
echo "  🚀 New pods being created"
echo "  ⚡ Load distributed across pods"
echo ""
echo "Stop stress test:"
echo "  kubectl delete pod stress-test -n todoapp"
