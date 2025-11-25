#!/bin/bash

echo "╔═══════════════════════════════════════════╗"
echo "║       Installing Knative                  ║"
echo "╚═══════════════════════════════════════════╝"

# Install Knative Serving
kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.12.0/serving-crds.yaml
kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.12.0/serving-core.yaml

# Install Kourier
kubectl apply -f https://github.com/knative/net-kourier/releases/download/knative-v1.12.0/kourier.yaml

kubectl patch configmap/config-network \
  --namespace knative-serving \
  --type merge \
  --patch '{"data":{"ingress-class":"kourier.ingress.networking.knative.dev"}}'

sleep 60

echo ""
echo "✅ Knative installed!"
