# 🚀 Production-Ready Kubernetes Platform

[![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)](https://kubernetes.io/)
[![Prometheus](https://img.shields.io/badge/Prometheus-E6522C?style=for-the-badge&logo=prometheus&logoColor=white)](https://prometheus.io/)
[![Grafana](https://img.shields.io/badge/Grafana-F46800?style=for-the-badge&logo=grafana&logoColor=white)](https://grafana.com/)
[![ArgoCD](https://img.shields.io/badge/ArgoCD-EF7B4D?style=for-the-badge&logo=argo&logoColor=white)](https://argoproj.github.io/cd/)
[![Helm](https://img.shields.io/badge/Helm-0F1689?style=for-the-badge&logo=helm&logoColor=white)](https://helm.sh/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

> **A complete, production-ready Kubernetes platform built from bare metal with enterprise-grade observability, CI/CD, security, and disaster recovery.**

---

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Components](#components)
- [Installation](#installation)
- [Access & Credentials](#access--credentials)
- [Monitoring](#monitoring)
- [Security](#security)
- [Backup & Recovery](#backup--recovery)
- [Troubleshooting](#troubleshooting)

---

## 🎯 Overview

This repository contains everything needed to build a **production-ready Kubernetes platform** with:

- ✅ **3-node high-availability cluster** using K3s
- ✅ **Complete observability** (Prometheus, Grafana, Loki)
- ✅ **GitOps CI/CD** with ArgoCD
- ✅ **Automated backups** with Velero & MinIO
- ✅ **Enterprise security** (Network Policies, RBAC, Pod Security)
- ✅ **Advanced features** (Helm, Cert-Manager, Kyverno)

**💰 Cost:** $0 (100% open source)  
**💼 Commercial Equivalent:** $10,000+/year  
**⏱️ Setup Time:** 4-8 hours (with automation scripts)

---

## ⭐ Features

### Infrastructure
- 🏗️ **3-node Kubernetes cluster** (K3s) with HA configuration
- 🔄 **Load balancing** with Traefik ingress controller
- 💾 **Persistent storage** with local-path provisioner
- 📊 **Metrics server** for resource monitoring

### Observability
- 📈 **Prometheus** - Metrics collection and alerting
- 📊 **Grafana** - Beautiful dashboards and visualization
- 📝 **Loki** - Centralized log aggregation
- 🔍 **Promtail** - Log collection from all nodes

### Operations
- 🔄 **ArgoCD** - GitOps continuous deployment
- ⚖️ **Horizontal Pod Autoscaler** - Automatic scaling
- 💾 **Velero** - Cluster backup and disaster recovery
- 🗄️ **MinIO** - S3-compatible backup storage

### Security
- 🔒 **Network Policies** - Pod-to-pod firewall (27+ policies)
- 👥 **RBAC** - Role-based access control (4 custom roles)
- 🛡️ **Pod Security Standards** - Baseline enforcement
- ⚖️ **Resource Quotas** - Prevent resource exhaustion
- 🔐 **Cert-Manager** - Automated TLS certificate management
- 📜 **Kyverno** - Policy-as-code governance

---

## 🏗️ Architecture
```
┌─────────────────────────────────────────────────────────────┐
│                     Kubernetes Cluster                       │
│                                                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │  k3s-master  │  │ k3s-worker1  │  │ k3s-worker2  │     │
│  │  (Control)   │  │   (Worker)   │  │   (Worker)   │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
│                                                              │
│  Observability | Operations | Security | Advanced           │
└─────────────────────────────────────────────────────────────┘
```

---

## 📋 Prerequisites

### Hardware Requirements
- **3 Virtual Machines** (or physical servers)
  - Master: 4 vCPU, 8GB RAM, 100GB disk
  - Worker1: 4 vCPU, 8GB RAM, 100GB disk
  - Worker2: 4 vCPU, 8GB RAM, 100GB disk

### Software Requirements
- **OS:** Ubuntu 24.04 LTS
- **Network:** Static IPs
- **Access:** SSH with sudo privileges

---

## 🚀 Quick Start

### Automated Installation
```bash
# Clone repository
git clone https://github.com/Newbigfonsz/kubernetes-production-platform.git
cd kubernetes-production-platform

# Run installation
./scripts/99-complete-installation.sh
```

### Manual Installation

See detailed guides in the [docs](./docs) directory.

---

## 🔧 Components

| Component | Version | Purpose | Access |
|-----------|---------|---------|--------|
| **K3s** | Latest | Kubernetes | - |
| **Prometheus** | v2.48+ | Metrics | :30090 |
| **Grafana** | v10.2+ | Dashboards | :30300 |
| **Loki** | v2.9+ | Logs | Internal |
| **ArgoCD** | v2.9+ | GitOps | :32012 |
| **Velero** | v1.12+ | Backup | CLI |
| **MinIO** | Latest | Storage | :30900 |

---

## 🔑 Access & Credentials
```bash
# ArgoCD
http://192.168.1.201:32012
admin / <get-password-from-secret>

# Grafana
http://192.168.1.201:30300
admin / prom-operator

# Prometheus
http://192.168.1.201:30090

# MinIO
http://192.168.1.201:30900
minio / minio123
```

---

## 📊 Platform Statistics
```
✅ Components: 15+
✅ Namespaces: 12
✅ Pods: 50+
✅ Network Policies: 27+
✅ RBAC Roles: 4 custom
✅ Automated Backups: Daily

💰 Cost: $0
💼 Value: $10,000+/year
```

---

## 📝 License

MIT License - See [LICENSE](LICENSE)

---

## 🙏 Acknowledgments

Built with open source technologies:
- K3s, Prometheus, Grafana, Loki, ArgoCD, Velero, and more!

---

**Built with ❤️ for the DevOps community**

*If this project helped you, please give it a ⭐!*
