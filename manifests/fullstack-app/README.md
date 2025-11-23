# Full-Stack Todo Application

A complete full-stack application demonstrating end-to-end deployment on Kubernetes.

## Architecture
```
┌─────────────┐
│   React     │  Frontend (NodePort 30800)
│  Frontend   │  
└──────┬──────┘
       │
       ▼
┌─────────────┐
│   Node.js   │  Backend API (ClusterIP 3000)
│   Express   │  
└──────┬──────┘
       │
       ▼
┌─────────────┐
│ PostgreSQL  │  Database (3-node HA cluster)
│   Cluster   │  
└─────────────┘
```

## Components

- **Frontend**: React.js with Material Design
- **Backend**: Node.js + Express REST API
- **Database**: PostgreSQL 16 with CloudNativePG operator

## Features

- ✅ Full CRUD operations (Create, Read, Update, Delete)
- ✅ Real-time UI updates
- ✅ Persistent storage
- ✅ High availability (3 DB replicas, 2 backend pods, 2 frontend pods)
- ✅ Complete observability integration

## Deployment
```bash
# 1. Create namespace
kubectl create namespace todoapp

# 2. Deploy database
kubectl apply -f database/postgres-cluster.yaml

# 3. Initialize database schema
# (See main README for full instructions)

# 4. Deploy backend
kubectl apply -f backend/backend-deployment-simple.yaml

# 5. Deploy frontend
kubectl apply -f frontend/frontend-direct-api.yaml

# 6. Access application
open http://YOUR_NODE_IP:30800
```

## Access

- **Frontend**: http://NODE_IP:30800
- **Backend API**: http://NODE_IP:30300/api/todos

## Technology Stack

- React.js
- Node.js 18
- Express.js 4.x
- PostgreSQL 16
- Kubernetes (K3s)
- CloudNativePG operator
