#!/bin/bash

echo "╔═══════════════════════════════════════════╗"
echo "║       Installing Pixie (eBPF Magic!)      ║"
echo "╚═══════════════════════════════════════════╝"

# Download Pixie CLI
bash -c "$(curl -fsSL https://withpixie.ai/install.sh)"

# Add to PATH
export PATH=$PATH:$HOME/.local/bin

echo ""
echo "✅ Pixie CLI installed!"
echo ""
echo "To deploy Pixie to your cluster:"
echo "  1. Create account at: https://work.withpixie.ai"
echo "  2. Run: px deploy"
echo ""
echo "Pixie gives you:"
echo "  🔍 Auto-instrumentation (no code changes!)"
echo "  📊 Application-level metrics"
echo "  🌐 Network traffic analysis"
echo "  🔐 Full request/response bodies"
echo "  🐛 Live debugging"
echo "  📈 Service maps"
echo "  ⚡ eBPF-powered (zero overhead!)"
