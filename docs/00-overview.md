# Platform Overview

## Architecture

This platform consists of:

1. **Infrastructure Layer**
   - 3-node K3s cluster
   - Load balancing with Traefik
   - Persistent storage

2. **Observability Layer**
   - Prometheus (metrics)
   - Grafana (dashboards)
   - Loki (logs)
   - Promtail (log collection)

3. **Operations Layer**
   - ArgoCD (GitOps CI/CD)
   - Velero (backup & DR)
   - MinIO (backup storage)
   - HPA (autoscaling)

4. **Security Layer**
   - Network Policies
   - RBAC
   - Pod Security Standards
   - Resource Quotas

5. **Advanced Features**
   - Helm (package management)
   - Cert-Manager (TLS automation)
   - Kyverno (policy engine)

## Components

See [Components List](./components.md) for detailed information.

## Installation

See numbered guides (01-08) for step-by-step installation.
