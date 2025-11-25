#!/bin/bash

echo "╔═══════════════════════════════════════════╗"
echo "║       Installing Cilium + Hubble          ║"
echo "╚═══════════════════════════════════════════╝"

# Install Cilium CLI
CILIUM_CLI_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/cilium-cli/main/stable.txt)
CLI_ARCH=amd64
curl -L --fail --remote-name-all https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}
sha256sum --check cilium-linux-${CLI_ARCH}.tar.gz.sha256sum
sudo tar xzvfC cilium-linux-${CLI_ARCH}.tar.gz /usr/local/bin
rm cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}

# Install Hubble CLI
export HUBBLE_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/hubble/master/stable.txt)
curl -L --fail --remote-name-all https://github.com/cilium/hubble/releases/download/$HUBBLE_VERSION/hubble-linux-${CLI_ARCH}.tar.gz{,.sha256sum}
sha256sum --check hubble-linux-${CLI_ARCH}.tar.gz.sha256sum
sudo tar xzvfC hubble-linux-${CLI_ARCH}.tar.gz /usr/local/bin
rm hubble-linux-${CLI_ARCH}.tar.gz{,.sha256sum}

echo ""
echo "✅ Cilium & Hubble CLI installed!"
echo ""
echo "Note: Cilium replaces your CNI (requires cluster rebuild)"
echo "Or install alongside for network policies only"
echo ""
echo "Features:"
echo "  🐝 eBPF-based networking (fastest possible)"
echo "  🔍 Hubble observability (see ALL network flows)"
echo "  🛡️ Network policies (L3-L7)"
echo "  🚀 Load balancing (eBPF XDP)"
echo "  🔒 Encryption (WireGuard, IPSec)"
