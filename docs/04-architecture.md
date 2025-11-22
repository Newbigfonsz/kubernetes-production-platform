# Platform Architecture

## Overview

This platform consists of multiple layers providing complete infrastructure,
observability, operations, and security capabilities.

## Component Diagram
```
┌─────────────────────────────────────────────────────────────┐
│                   KUBERNETES CLUSTER                         │
│                                                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │  k3s-master  │  │ k3s-worker1  │  │ k3s-worker2  │     │
│  │  192.168.1   │  │ 192.168.1    │  │ 192.168.1    │     │
│  │  .201        │  │ .202         │  │ .203         │     │
│  │              │  │              │  │              │     │
│  │ Control      │  │ Worker Node  │  │ Worker Node  │     │
│  │ Plane        │  │              │  │              │     │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘     │
│         │                  │                  │              │
│         └──────────────────┴──────────────────┘              │
│                            │                                 │
└────────────────────────────┼─────────────────────────────────┘
                             │
        ┌────────────────────┼────────────────────┐
        │                    │                    │
┌───────▼────────┐  ┌────────▼────────┐  ┌───────▼────────┐
│ OBSERVABILITY  │  │   OPERATIONS    │  │    SECURITY    │
│                │  │                 │  │                │
│ • Prometheus   │  │ • ArgoCD        │  │ • Net Policies │
│ • Grafana      │  │ • Velero        │  │ • RBAC         │
│ • Loki         │  │ • MinIO         │  │ • Pod Security │
│ • Promtail     │  │ • HPA           │  │ • Quotas       │
└────────────────┘  └─────────────────┘  └────────────────┘
```

## Data Flow

### Metrics Flow
```
Application → Prometheus → Grafana → User
                ↓
           Long-term Storage
```

### Logs Flow
```
Application → Promtail → Loki → Grafana → User
```

### CI/CD Flow
```
Git Repo → ArgoCD → Kubernetes → Application
```

### Backup Flow
```
Kubernetes Resources → Velero → MinIO → S3 Storage
```

## Network Architecture

- **Pod Network:** 10.42.0.0/16
- **Service Network:** 10.43.0.0/16
- **Node Network:** 192.168.1.0/24
- **Ingress:** Traefik on all nodes

## Security Layers

1. **Network Layer:** Network Policies
2. **Access Layer:** RBAC
3. **Pod Layer:** Pod Security Standards
4. **Resource Layer:** Resource Quotas
5. **Policy Layer:** Kyverno Policies
