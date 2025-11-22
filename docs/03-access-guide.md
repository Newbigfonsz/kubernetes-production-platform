# Service Access Guide

## Web Interfaces

### ArgoCD (GitOps CI/CD)
- **URL:** http://192.168.1.201:32012
- **Username:** admin
- **Password:** 
```bash
  kubectl -n argocd get secret argocd-initial-admin-secret \
    -o jsonpath='{.data.password}' | base64 -d
```

### Grafana (Monitoring Dashboards)
- **URL:** http://192.168.1.201:30300
- **Username:** admin
- **Password:** prom-operator

### Prometheus (Metrics)
- **URL:** http://192.168.1.201:30090
- **Authentication:** None

### MinIO (Backup Storage)
- **URL:** http://192.168.1.201:30900
- **Username:** minio
- **Password:** minio123

### Kubernetes Dashboard
- **URL:** https://192.168.1.201:30443
- **Token:** 
```bash
  kubectl -n kubernetes-dashboard create token admin-user --duration=87600h
```

## CLI Access

### kubectl
```bash
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
kubectl get nodes
```

### ArgoCD CLI
```bash
argocd login 192.168.1.201:32012
argocd app list
```

### Velero CLI
```bash
velero backup get
velero restore create --from-backup backup-name
```

### Helm
```bash
helm list --all-namespaces
helm repo list
```
