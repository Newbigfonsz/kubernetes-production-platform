#!/bin/bash

echo "╔═══════════════════════════════════════════╗"
echo "║    Configuring Loki in Grafana            ║"
echo "╚═══════════════════════════════════════════╝"

GRAFANA_POD=$(kubectl get pods -n monitoring -l app=grafana -o jsonpath='{.items[0].metadata.name}')

# Add Loki datasource
kubectl exec -n monitoring $GRAFANA_POD -- curl -X POST \
  http://admin:admin@localhost:3000/api/datasources \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Loki",
    "type": "loki",
    "url": "http://loki:3100",
    "access": "proxy",
    "isDefault": false,
    "jsonData": {
      "maxLines": 1000
    }
  }' 2>/dev/null

echo ""
echo "✅ Loki datasource added to Grafana!"
echo ""
echo "Now you can:"
echo "  📝 View logs in Grafana"
echo "  🔍 Search logs with LogQL"
echo "  📊 Create log-based dashboards"
