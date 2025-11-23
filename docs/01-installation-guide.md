# 📦 Installation Guide

Complete step-by-step guide to deploy this Kubernetes platform.

---

## Prerequisites

### Hardware Requirements

- **3 Ubuntu 24.04 VMs** (or physical servers)
  - Master Node: 4 vCPU, 8GB RAM, 30GB disk
  - Worker Node 1: 4 vCPU, 8GB RAM, 30GB disk
  - Worker Node 2: 4 vCPU, 8GB RAM, 30GB disk

### Network Requirements

- Static IP addresses for all nodes
- Open ports between nodes:
  - 6443 (Kubernetes API)
  - 10250 (Kubelet)
  - 2379-2380 (etcd)
  - 8472 (Flannel VXLAN)

### Software Requirements

- Ubuntu 24.04 LTS
- SSH access with sudo privileges
- Internet connectivity for package downloads

---

## Quick Installation (Automated)
```bash
# Clone repository
git clone https://github.com/Newbigfonsz/kubernetes-production-platform.git
cd kubernetes-production-platform

# Run complete installation (takes ~30 minutes)
./scripts/99-complete-installation.sh
```

This will install everything automatically!

---

## Manual Installation (Step-by-Step)

### Step 1: Install K3s Master Node

On the **master node** (192.168.1.201):
```bash
cd ~/kubernetes-production-platform
./scripts/01-install-k3s-master.sh
```

Verify:
```bash
kubectl get nodes
```

### Step 2: Install K3s Worker Nodes

On **each worker node** (192.168.1.202, 192.168.1.203):
```bash
# Edit the script to update master IP if needed
./scripts/02-install-k3s-workers.sh
```

Verify:
```bash
kubectl get nodes
# Should show 3 nodes in Ready state
```

### Step 3: Install Monitoring Stack
```bash
./scripts/03-install-monitoring.sh
```

This installs:
- Prometheus (metrics)
- Grafana (dashboards)
- Node Exporter
- Kube-State-Metrics

Access Grafana: http://NODE_IP:30300

### Step 4: Install Logging Stack
```bash
./scripts/04-install-logging.sh
```

This installs:
- Loki (log aggregation)
- Promtail (log collection)
- Integration with Grafana

### Step 5: Install Tracing
```bash
# Included in monitoring script
kubectl apply -f manifests/monitoring/jaeger.yaml
```

Access Jaeger: http://NODE_IP:16686

### Step 6: Install ArgoCD (CI/CD)
```bash
./scripts/05-install-argocd.sh
```

Access ArgoCD: http://NODE_IP:32012
Default password is in the script output.

### Step 7: Install Backup Solution
```bash
./scripts/06-install-backup.sh
```

This installs:
- MinIO (S3-compatible storage)
- Velero (backup operator)
- Automated daily backups

### Step 8: Configure Security
```bash
./scripts/07-install-security.sh
```

This configures:
- 27+ Network Policies
- 4 Custom RBAC Roles
- Pod Security Standards
- Resource Quotas

### Step 9: Install Advanced Features
```bash
./scripts/08-install-advanced.sh
```

This installs:
- Helm package manager
- Cert-Manager (TLS automation)
- Kyverno (policy engine)
- Kubernetes Dashboard

### Step 10: Deploy Full-Stack Application
```bash
kubectl create namespace todoapp
kubectl apply -f manifests/fullstack-app/database/
kubectl apply -f manifests/fullstack-app/backend/
kubectl apply -f manifests/fullstack-app/frontend/
```

Access Todo App: http://NODE_IP:30800

---

## Post-Installation Verification

### Check All Components
```bash
# All namespaces
kubectl get namespaces

# All pods
kubectl get pods --all-namespaces

# All services
kubectl get svc --all-namespaces

# Node status
kubectl get nodes -o wide
```

### Access Web Interfaces

- **Todo App**: http://NODE_IP:30800
- **Grafana**: http://NODE_IP:30300 (admin/admin)
- **Prometheus**: http://NODE_IP:9090
- **Jaeger**: http://NODE_IP:16686
- **ArgoCD**: http://NODE_IP:32012
- **Kubernetes Dashboard**: https://NODE_IP:30443

### Test Monitoring
```bash
# Check Prometheus targets
curl -s http://localhost:9090/api/v1/targets | jq '.data.activeTargets | length'

# Check Grafana health
curl -s http://localhost:30300/api/health
```

### Test Backup
```bash
# List backup schedules
velero schedule get

# Create test backup
velero backup create test-backup --include-namespaces todoapp

# Check backup status
velero backup describe test-backup
```

---

## Troubleshooting Installation

### Pods Not Starting
```bash
# Check pod status
kubectl get pods -n <namespace>

# Check pod logs
kubectl logs <pod-name> -n <namespace>

# Describe pod for events
kubectl describe pod <pod-name> -n <namespace>
```

### Network Issues
```bash
# Check network plugin
kubectl get pods -n kube-system | grep flannel

# Test DNS
kubectl run test --rm -it --image=busybox -- nslookup kubernetes.default

# Check network policies
kubectl get networkpolicies --all-namespaces
```

### Storage Issues
```bash
# Check PV/PVC
kubectl get pv,pvc --all-namespaces

# Check storage class
kubectl get storageclass
```

---

## Uninstallation

To completely remove the platform:
```bash
# On each worker node
/usr/local/bin/k3s-agent-uninstall.sh

# On master node
/usr/local/bin/k3s-uninstall.sh

# Clean up data
sudo rm -rf /var/lib/rancher/k3s
sudo rm -rf /etc/rancher/k3s
```

---

## Next Steps

- [Access Guide](02-access-guide.md) - How to access all services
- [Architecture](03-architecture.md) - Understanding the platform
- [Troubleshooting](04-troubleshooting.md) - Common issues and solutions
