# Quick Start Guide

## Prerequisites

- 3 Ubuntu 24.04 VMs
- Static IP addresses
- SSH access
- sudo privileges

## Installation

### Option 1: Automated (Recommended)
```bash
git clone https://github.com/Newbigfonsz/kubernetes-production-platform.git
cd kubernetes-production-platform
./scripts/99-complete-installation.sh
```

### Option 2: Step-by-Step
```bash
./scripts/01-install-k3s-master.sh
./scripts/02-install-k3s-workers.sh
./scripts/03-install-monitoring.sh
./scripts/04-install-logging.sh
./scripts/05-install-argocd.sh
./scripts/06-install-backup.sh
./scripts/07-install-security.sh
./scripts/08-install-advanced.sh
```

## Verification
```bash
kubectl get nodes
kubectl get pods --all-namespaces
```

## Access Services

- ArgoCD: http://192.168.1.201:32012
- Grafana: http://192.168.1.201:30300
- Prometheus: http://192.168.1.201:30090
- MinIO: http://192.168.1.201:30900
