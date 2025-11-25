#!/bin/bash

echo "╔═══════════════════════════════════════════╗"
echo "║       Installing Telepresence             ║"
echo "╚═══════════════════════════════════════════╝"

# Install Telepresence
sudo curl -fL https://app.getambassador.io/download/tel2oss/releases/download/v2.19.1/telepresence-linux-amd64 -o /usr/local/bin/telepresence
sudo chmod +x /usr/local/bin/telepresence

telepresence version

echo ""
echo "✅ Telepresence installed!"
echo ""
echo "Usage:"
echo "  telepresence connect"
echo "  telepresence list"
echo "  telepresence intercept <service-name>"
echo ""
echo "Features:"
echo "  💻 Local development with cluster access"
echo "  🔄 Intercept traffic to services"
echo "  🐛 Debug services locally"
echo "  ⚡ Fast inner dev loop"
