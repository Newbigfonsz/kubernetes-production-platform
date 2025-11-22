# Installation Scripts

## Order of Execution

1. `00-prerequisites.sh` - System preparation
2. `01-install-k3s-master.sh` - Master node setup
3. `02-install-k3s-workers.sh` - Worker nodes setup
4. `03-install-monitoring.sh` - Prometheus + Grafana
5. `04-install-logging.sh` - Loki + Promtail
6. `05-install-argocd.sh` - ArgoCD CI/CD
7. `06-install-backup.sh` - Velero + MinIO
8. `07-install-security.sh` - Security hardening
9. `08-install-advanced.sh` - Advanced features
10. `99-complete-installation.sh` - Full automation

## Usage
```bash
# Make scripts executable
chmod +x scripts/*.sh

# Run individual script
./scripts/01-install-k3s-master.sh

# Or run complete installation
./scripts/99-complete-installation.sh
```
