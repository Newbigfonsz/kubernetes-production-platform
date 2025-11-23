# 🌐 Access Guide

How to access all services in the platform.

---

## Web Interfaces

### Full-Stack Todo Application

**URL**: `http://NODE_IP:30800`

- **Type**: NodePort Service
- **Default**: Works immediately after installation
- **Features**: Create, read, update, delete todos

**First-time setup**: None required!

---

### Grafana (Monitoring Dashboards)

**URL**: `http://NODE_IP:30300`

**Default Credentials**:
- Username: `admin`
- Password: `admin` (change on first login)

**Pre-configured Dashboards**:
- Kubernetes Cluster Overview
- Node Metrics
- Pod Metrics
- Application Metrics

**Features**:
- Real-time metrics
- Log exploration (Loki)
- Alert visualization

---

### Prometheus (Metrics)

**URL**: `http://NODE_IP:9090`

**No authentication required**

**Useful Queries**:
```promql
# Pod CPU usage
rate(container_cpu_usage_seconds_total[5m])

# Memory usage
container_memory_usage_bytes

# HTTP request rate
rate(http_requests_total[5m])
```

---

### Jaeger (Distributed Tracing)

**URL**: `http://NODE_IP:16686`

**No authentication required**

**Features**:
- View distributed traces
- Find performance bottlenecks
- Analyze request paths

**Usage**:
1. Select service from dropdown
2. Click "Find Traces"
3. Click on trace to see details

---

### ArgoCD (GitOps CD)

**URL**: `http://NODE_IP:32012`

**Get Initial Password**:
```bash
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d; echo
```

**Default Username**: `admin`

**Features**:
- View application deployments
- Sync from Git repositories
- View deployment history
- Rollback applications

---

### MinIO (Backup Storage)

**URL**: `http://NODE_IP:9001`

**Default Credentials**:
- Username: `minio`
- Password: `minio123`

**Features**:
- View backup buckets
- Browse backup files
- Monitor storage usage

---

### Kubernetes Dashboard

**URL**: `https://NODE_IP:30443`

**Get Token**:
```bash
kubectl -n kubernetes-dashboard create token admin-user
```

**Features**:
- Visual cluster management
- Pod logs
- Resource editing
- Event viewing

---

## CLI Access

### kubectl

Access cluster from master node:
```bash
kubectl get nodes
kubectl get pods --all-namespaces
kubectl logs <pod-name> -n <namespace>
```

### Port Forwarding

Access services locally:
```bash
# Forward Grafana
kubectl port-forward -n monitoring svc/grafana 3000:80

# Forward backend API
kubectl port-forward -n todoapp svc/todoapp-backend 3000:3000
```

### Pod Shell Access
```bash
# Execute commands in pod
kubectl exec -it <pod-name> -n <namespace> -- /bin/sh

# Example: Access database
kubectl exec -it todoapp-db-1 -n todoapp -c postgres -- psql -U postgres
```

---

## Service Endpoints

### Internal Services (ClusterIP)

These are only accessible within the cluster:

| Service | Namespace | Port | Internal DNS |
|---------|-----------|------|--------------|
| todoapp-backend | todoapp | 3000 | todoapp-backend.todoapp.svc.cluster.local |
| todoapp-db-rw | todoapp | 5432 | todoapp-db-rw.todoapp.svc.cluster.local |
| prometheus | monitoring | 9090 | prometheus.monitoring.svc.cluster.local |

### External Services (NodePort)

These are accessible from outside the cluster:

| Service | Namespace | NodePort | External URL |
|---------|-----------|----------|--------------|
| todoapp-frontend | todoapp | 30800 | http://NODE_IP:30800 |
| grafana | monitoring | 30300 | http://NODE_IP:30300 |
| jaeger | monitoring | 16686 | http://NODE_IP:16686 |
| argocd-server | argocd | 32012 | http://NODE_IP:32012 |
| minio-console | backup | 9001 | http://NODE_IP:9001 |

---

## API Access

### Backend REST API

**Base URL**: `http://NODE_IP:30300/api`

**Endpoints**:
```bash
# Get all todos
curl http://NODE_IP:30300/api/todos

# Create todo
curl -X POST http://NODE_IP:30300/api/todos \
  -H "Content-Type: application/json" \
  -d '{"title":"Test","description":"Testing API"}'

# Update todo
curl -X PUT http://NODE_IP:30300/api/todos/1 \
  -H "Content-Type: application/json" \
  -d '{"completed":true}'

# Delete todo
curl -X DELETE http://NODE_IP:30300/api/todos/1
```

### Kubernetes API
```bash
# Get cluster info
kubectl cluster-info

# API server URL
kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}'
```

---

## Monitoring Access

### View Metrics
```bash
# Pod metrics
kubectl top pods --all-namespaces

# Node metrics
kubectl top nodes

# Specific namespace
kubectl top pods -n todoapp
```

### View Logs
```bash
# Pod logs
kubectl logs <pod-name> -n <namespace>

# Follow logs
kubectl logs -f <pod-name> -n <namespace>

# Previous container logs
kubectl logs <pod-name> -n <namespace> --previous
```

### View Events
```bash
# All events
kubectl get events --all-namespaces --sort-by='.lastTimestamp'

# Namespace events
kubectl get events -n todoapp
```

---

## Backup Access

### List Backups
```bash
# List all backups
velero backup get

# Describe specific backup
velero backup describe <backup-name>

# Get backup logs
velero backup logs <backup-name>
```

### Restore from Backup
```bash
# Restore specific backup
velero restore create --from-backup <backup-name>

# Check restore status
velero restore get
```

---

## Security Access

### View RBAC
```bash
# List roles
kubectl get roles --all-namespaces

# List role bindings
kubectl get rolebindings --all-namespaces

# Check permissions
kubectl auth can-i create pods -n todoapp
```

### View Network Policies
```bash
# List network policies
kubectl get networkpolicies --all-namespaces

# Describe policy
kubectl describe networkpolicy <policy-name> -n <namespace>
```

---

## Troubleshooting Access Issues

### Can't Access Web Interfaces

1. Check service is running:
```bash
kubectl get svc -n <namespace>
```

2. Check pods are ready:
```bash
kubectl get pods -n <namespace>
```

3. Check NodePort is accessible:
```bash
# Test from master node
curl http://localhost:<nodeport>
```

4. Check firewall:
```bash
sudo ufw status
```

### Authentication Issues

**Grafana**: Reset admin password:
```bash
kubectl exec -it -n monitoring <grafana-pod> -- grafana-cli admin reset-admin-password newpassword
```

**ArgoCD**: Reset admin password:
```bash
kubectl -n argocd patch secret argocd-secret \
  -p '{"stringData": {"admin.password": "new-password"}}'
```

### Port Already in Use
```bash
# Find process using port
sudo lsof -i :30800

# Kill process
sudo kill -9 <PID>
```

---

## Next Steps

- [Architecture](03-architecture.md) - Understand the platform design
- [Troubleshooting](04-troubleshooting.md) - Fix common issues
