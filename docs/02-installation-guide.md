# Installation Guide

## Step-by-Step Installation

### 1. Prerequisites

Ensure you have:
- 3 Ubuntu 24.04 VMs
- Static IP addresses configured
- SSH access with sudo privileges

### 2. Install K3s Master
```bash
# On master node (192.168.1.201)
curl -sfL https://get.k3s.io | sh -s - \
  --write-kubeconfig-mode 644 \
  --disable traefik \
  --node-name k3s-master

# Get join token
sudo cat /var/lib/rancher/k3s/server/node-token
```

### 3. Install K3s Workers
```bash
# On worker nodes (192.168.1.202, 192.168.1.203)
curl -sfL https://get.k3s.io | K3S_URL=https://192.168.1.201:6443 \
  K3S_TOKEN="YOUR_TOKEN" \
  sh -s - \
  --node-name k3s-worker1
```

### 4. Install Components
```bash
# Run installation scripts
./scripts/03-install-monitoring.sh
./scripts/04-install-logging.sh
./scripts/05-install-argocd.sh
./scripts/06-install-backup.sh
./scripts/07-install-security.sh
./scripts/08-install-advanced.sh
```

### 5. Verify Installation
```bash
kubectl get nodes
kubectl get pods --all-namespaces
```

## Access Services

See [Access Guide](./03-access-guide.md) for URLs and credentials.
