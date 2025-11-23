# 🔧 Troubleshooting Guide

Common issues and their solutions.

---

## Quick Diagnostics

### Check Overall Health
```bash
# All pods status
kubectl get pods --all-namespaces

# Node status
kubectl get nodes

# Component health
kubectl get componentstatuses

# Events (recent issues)
kubectl get events --all-namespaces --sort-by='.lastTimestamp' | tail -20
```

---

## Common Issues

### 1. Pods Not Starting

#### Symptom
```
NAME                     READY   STATUS             RESTARTS
my-pod-xxxxx             0/1     CrashLoopBackOff   5
```

#### Diagnosis
```bash
# Check pod details
kubectl describe pod <pod-name> -n <namespace>

# Check logs
kubectl logs <pod-name> -n <namespace>

# Check previous container logs
kubectl logs <pod-name> -n <namespace> --previous
```

#### Common Causes & Solutions

**Image Pull Error**:
```bash
# Check if image exists
kubectl describe pod <pod-name> -n <namespace> | grep -A 5 "Events:"

# Solution: Fix image name/tag or add image pull secret
```

**Insufficient Resources**:
```bash
# Check node resources
kubectl describe nodes | grep -A 5 "Allocated resources"

# Solution: Reduce resource requests or add nodes
```

**Configuration Error**:
```bash
# Check ConfigMap/Secret exists
kubectl get configmap -n <namespace>
kubectl get secret -n <namespace>

# Solution: Create missing ConfigMap/Secret
```

---

### 2. Service Not Accessible

#### Symptom
- Can't access service via NodePort
- Service returns connection refused

#### Diagnosis
```bash
# Check service
kubectl get svc -n <namespace>

# Check endpoints
kubectl get endpoints -n <namespace>

# Check if pods are ready
kubectl get pods -n <namespace> -l app=<your-app>
```

#### Solutions

**No Endpoints**:
```bash
# Service selector doesn't match pod labels
kubectl get svc <service-name> -n <namespace> -o yaml | grep selector
kubectl get pods -n <namespace> --show-labels

# Solution: Fix service selector or pod labels
```

**NodePort Not Working**:
```bash
# Check firewall
sudo ufw status

# Allow port
sudo ufw allow <nodeport>

# Check if port is listening
sudo netstat -tulpn | grep <nodeport>
```

**DNS Not Resolving**:
```bash
# Test DNS from pod
kubectl run test --rm -it --image=busybox -- nslookup kubernetes.default

# Check CoreDNS
kubectl get pods -n kube-system -l k8s-app=kube-dns

# Restart CoreDNS
kubectl rollout restart deployment/coredns -n kube-system
```

---

### 3. Database Connection Issues

#### Symptom
- Backend can't connect to PostgreSQL
- "relation does not exist" errors

#### Diagnosis
```bash
# Check database pods
kubectl get pods -n todoapp -l cnpg.io/cluster=todoapp-db

# Check database services
kubectl get svc -n todoapp | grep db

# Test connection from backend pod
BACKEND_POD=$(kubectl get pods -n todoapp -l component=backend -o jsonpath='{.items[0].metadata.name}')
kubectl exec -n todoapp $BACKEND_POD -- wget -qO- http://todoapp-db-rw:5432
```

#### Solutions

**Table Doesn't Exist**:
```bash
# Create table manually
kubectl port-forward -n todoapp svc/todoapp-db-rw 5432:5432 &
PGPASSWORD=todopass123 psql -h localhost -U todouser -d tododb -f init-schema.sql
pkill -f "port-forward"
```

**Wrong Service Name**:
```bash
# Check correct service name
kubectl get svc -n todoapp | grep db

# Update backend environment variable
kubectl set env deployment/todoapp-backend -n todoapp \
  DB_HOST=<correct-service-name>.todoapp.svc.cluster.local
```

**Authentication Failed**:
```bash
# Check credentials secret
kubectl get secret todoapp-db-credentials -n todoapp -o yaml

# Recreate if needed
kubectl delete secret todoapp-db-credentials -n todoapp
kubectl create secret generic todoapp-db-credentials -n todoapp \
  --from-literal=username=todouser \
  --from-literal=password=todopass123
```

---

### 4. Monitoring Not Working

#### Prometheus Not Scraping
```bash
# Check Prometheus targets
kubectl port-forward -n monitoring svc/prometheus 9090:9090 &
curl http://localhost:9090/api/v1/targets | jq '.data.activeTargets[] | select(.health!="up")'

# Check ServiceMonitor
kubectl get servicemonitor -n monitoring

# Restart Prometheus
kubectl rollout restart statefulset/prometheus -n monitoring
```

#### Grafana Can't Query Prometheus
```bash
# Check Grafana datasource
kubectl exec -n monitoring <grafana-pod> -- grafana-cli admin data-sources list

# Re-add datasource
# Login to Grafana → Configuration → Data Sources → Add Prometheus
# URL: http://prometheus.monitoring.svc.cluster.local:9090
```

#### Logs Not Appearing in Loki
```bash
# Check Promtail pods
kubectl get pods -n monitoring -l app=promtail

# Check Promtail logs
kubectl logs -n monitoring -l app=promtail --tail=50

# Restart Promtail
kubectl rollout restart daemonset/promtail -n monitoring
```

---

### 5. ArgoCD Application Not Syncing

#### Symptom
- Application shows "Out of Sync"
- Sync fails with errors

#### Diagnosis
```bash
# Check application status
kubectl get applications -n argocd

# Get detailed status
kubectl describe application <app-name> -n argocd

# Check ArgoCD logs
kubectl logs -n argocd -l app.kubernetes.io/name=argocd-application-controller
```

#### Solutions

**Git Repository Unreachable**:
```bash
# Test from ArgoCD pod
kubectl exec -n argocd <argocd-pod> -- git ls-remote <repo-url>

# Add SSH key or credentials
argocd repo add <repo-url> --username <user> --password <token>
```

**Permission Issues**:
```bash
# Check ArgoCD RBAC
kubectl get clusterrole argocd-application-controller -o yaml

# Grant permissions if needed
kubectl create clusterrolebinding argocd-admin \
  --clusterrole=cluster-admin \
  --serviceaccount=argocd:argocd-application-controller
```

---

### 6. Backup/Restore Issues

#### Velero Backup Failing
```bash
# Check Velero status
velero backup get

# Describe failed backup
velero backup describe <backup-name>

# Check Velero logs
kubectl logs -n backup -l component=velero

# Check MinIO connectivity
kubectl exec -n backup <velero-pod> -- velero backup-location get
```

#### Restore Not Working
```bash
# Check restore status
velero restore describe <restore-name>

# Check for conflicts
kubectl get all -n <namespace>

# Force restore
velero restore create --from-backup <backup-name> \
  --include-namespaces <namespace> \
  --existing-resource-policy update
```

---

### 7. Performance Issues

#### High CPU Usage
```bash
# Find high CPU pods
kubectl top pods --all-namespaces --sort-by=cpu

# Check specific pod
kubectl top pod <pod-name> -n <namespace> --containers

# Check node resources
kubectl describe node <node-name> | grep -A 5 "Allocated resources"

# Solution: Add HPA or increase resources
kubectl autoscale deployment <name> --cpu-percent=70 --min=2 --max=10
```

#### High Memory Usage
```bash
# Find high memory pods
kubectl top pods --all-namespaces --sort-by=memory

# Check for memory leaks
kubectl logs <pod-name> -n <namespace> | grep -i "out of memory"

# Increase memory limits
kubectl set resources deployment <name> -n <namespace> \
  --limits=memory=512Mi \
  --requests=memory=256Mi
```

#### Disk Space Full
```bash
# Check disk usage
df -h

# Clean up Docker images
sudo docker system prune -a -f

# Clean up logs
sudo journalctl --vacuum-time=2d

# Clean up K3s
sudo k3s crictl rmi --prune
```

---

### 8. Network Policy Issues

#### Pods Can't Communicate
```bash
# Check network policies
kubectl get networkpolicies -n <namespace>

# Describe policy
kubectl describe networkpolicy <policy-name> -n <namespace>

# Test connectivity
kubectl run test --rm -it --image=busybox -n <namespace> -- wget -qO- http://<service>

# Temporarily disable policy for testing
kubectl delete networkpolicy <policy-name> -n <namespace>
```

---

### 9. Security Issues

#### Pod Security Standard Violations
```bash
# Check PSS labels
kubectl get namespaces --show-labels

# Check pod security violations
kubectl get pods -n <namespace> -o yaml | grep -A 10 "securityContext"

# Fix common violations
# - Add securityContext
# - Set runAsNonRoot: true
# - Drop all capabilities
# - Set readOnlyRootFilesystem: true
```

#### RBAC Permission Denied
```bash
# Check user permissions
kubectl auth can-i create pods -n <namespace> --as=<user>

# List roles
kubectl get rolebindings -n <namespace>

# Grant permission
kubectl create rolebinding <name> \
  --clusterrole=edit \
  --user=<user> \
  --namespace=<namespace>
```

---

### 10. Storage Issues

#### PVC Pending
```bash
# Check PVC status
kubectl get pvc -n <namespace>

# Describe PVC
kubectl describe pvc <pvc-name> -n <namespace>

# Check storage class
kubectl get storageclass

# Check available PVs
kubectl get pv

# Solution: Create PV or fix storage class
```

---

## Emergency Procedures

### Complete Cluster Reset
```bash
# Save current state
kubectl get all --all-namespaces -o yaml > cluster-backup.yaml

# On workers
sudo /usr/local/bin/k3s-agent-uninstall.sh

# On master
sudo /usr/local/bin/k3s-uninstall.sh

# Clean up
sudo rm -rf /var/lib/rancher/k3s
sudo rm -rf /etc/rancher/k3s

# Reinstall
./scripts/01-install-k3s-master.sh
./scripts/02-install-k3s-workers.sh
```

### Restore from Backup
```bash
# List backups
velero backup get

# Restore entire cluster
velero restore create --from-backup <backup-name>

# Restore specific namespace
velero restore create --from-backup <backup-name> \
  --include-namespaces <namespace>

# Check restore progress
velero restore describe <restore-name>
```

---

## Debug Tools

### Useful Commands
```bash
# Interactive debugging pod
kubectl run debug --rm -it --image=nicolaka/netshoot -- /bin/bash

# Port forward for local testing
kubectl port-forward -n <namespace> <pod-name> <local-port>:<pod-port>

# Copy files from pod
kubectl cp <namespace>/<pod>:/path/to/file ./local-file

# Execute command in pod
kubectl exec -it <pod> -n <namespace> -- /bin/sh

# Watch resources
kubectl get pods -n <namespace> --watch

# Get events
kubectl get events -n <namespace> --sort-by='.lastTimestamp'
```

### Logs
```bash
# All container logs
kubectl logs <pod> -n <namespace> --all-containers

# Follow logs
kubectl logs -f <pod> -n <namespace>

# Previous container
kubectl logs <pod> -n <namespace> --previous

# Since timestamp
kubectl logs <pod> -n <namespace> --since=1h

# Tail lines
kubectl logs <pod> -n <namespace> --tail=100
```

---

## Getting Help

### Log Collection
```bash
# Collect all diagnostics
kubectl get all --all-namespaces -o yaml > all-resources.yaml
kubectl get events --all-namespaces > events.log
kubectl logs -n <namespace> <pod> > pod.log
kubectl describe nodes > nodes.txt
```

### Community Resources

- Kubernetes Slack: kubernetes.slack.com
- K3s GitHub Issues: github.com/k3s-io/k3s
- Stack Overflow: stackoverflow.com/questions/tagged/kubernetes

---

## Next Steps

- [Installation Guide](01-installation-guide.md) - Fresh installation
- [Access Guide](02-access-guide.md) - Accessing services
- [Architecture](03-architecture.md) - Understanding the platform
