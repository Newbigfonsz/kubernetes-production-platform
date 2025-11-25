#!/bin/bash

echo "╔═══════════════════════════════════════════╗"
echo "║       Running Security Scan               ║"
echo "╚═══════════════════════════════════════════╝"

# Run kube-bench
kubectl apply -f https://raw.githubusercontent.com/aquasecurity/kube-bench/main/job.yaml

echo "Waiting for scan to complete (60 seconds)..."
sleep 60

# Get results
echo ""
echo "════════════════════════════════════════════"
echo "           SECURITY SCAN RESULTS            "
echo "════════════════════════════════════════════"
echo ""

kubectl logs -n default -l app=kube-bench | grep -A 50 "== Summary"

echo ""
echo "Full report:"
echo "  kubectl logs -n default -l app=kube-bench"
echo ""
echo "Clean up:"
echo "  kubectl delete job kube-bench"
