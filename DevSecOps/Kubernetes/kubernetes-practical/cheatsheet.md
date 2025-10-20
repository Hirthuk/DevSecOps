# 🧠 **Kubernetes Cheatsheet (DevOps Interview Version — Hands-on + Theory)**

Everything we’ve covered, neatly summarized for quick reference 🚀

---

## ⚙️ 1. What is Kubernetes?

* Kubernetes (K8s) is a **container orchestration platform**.
* It automates **deployment, scaling, and management** of containerized apps.
* You can manage containers across **multiple nodes** as one cluster.

---

## 🧩 2. Kubernetes Architecture (Core Components)

| Component                       | Description                                              |
| ------------------------------- | -------------------------------------------------------- |
| **Master Node / Control Plane** | Manages the cluster                                      |
| **etcd**                        | Stores cluster state (key-value database)                |
| **kube-apiserver**              | Main entry point for Kubernetes commands (via `kubectl`) |
| **kube-scheduler**              | Assigns Pods to nodes                                    |
| **kube-controller-manager**     | Ensures desired state (like number of Pods, nodes, etc.) |
| **Worker Node**                 | Runs your actual workloads (Pods)                        |
| **kubelet**                     | Agent on each node that runs Pods                        |
| **kube-proxy**                  | Handles networking and load balancing within the cluster |

---

## 🏗️ 3. Core Kubernetes Objects

| Object           | Purpose                                               |
| ---------------- | ----------------------------------------------------- |
| **Pod**          | Smallest deployable unit; runs one or more containers |
| **Deployment**   | Manages replicas (Pods) and handles updates/rollbacks |
| **ReplicaSet**   | Ensures a specific number of Pod replicas are running |
| **Service**      | Exposes Pods to the network                           |
| **ConfigMap**    | Stores non-sensitive configuration data               |
| **Secret**       | Stores sensitive data (like passwords, keys)          |
| **Ingress**      | Routes external traffic to services                   |
| **Namespace**    | Logical partition of cluster resources                |
| **Volume / PVC** | Persistent storage for Pods                           |

---

## 🧱 4. Deployment (Creating & Managing Pods)

### Example: `deployment.yaml`

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - name: my-container
        image: myapp:latest
        ports:
        - containerPort: 5173
```

### Commands:

```bash
kubectl apply -f deployment.yaml      # Create deployment
kubectl get deployments               # List deployments
kubectl get pods                      # View running pods
kubectl describe pod <pod-name>       # Details of a specific pod
kubectl logs <pod-name>               # View logs
kubectl delete -f deployment.yaml     # Delete deployment
```

---

## 🌐 5. Exposing Pods (Services)

| Service Type            | Description                                                                                         |
| ----------------------- | --------------------------------------------------------------------------------------------------- |
| **ClusterIP (default)** | Internal access only within cluster                                                                 |
| **NodePort**            | Exposes service on a static port on each Node (accessible from outside using `<NodeIP>:<NodePort>`) |
| **LoadBalancer**        | Integrates with cloud load balancers (AWS, GCP, Azure)                                              |

### Example:

```bash
kubectl expose deployment my-deployment --type=NodePort --port=5173
kubectl get svc
```

Then access via:

```
minikube service my-deployment --url
```

---

## 🧰 6. ConfigMaps & Secrets

### ConfigMap

```bash
kubectl create configmap my-config --from-literal=ENV=dev
```

Mount in Pod:

```yaml
envFrom:
  - configMapRef:
      name: my-config
```

### Secret

```bash
kubectl create secret generic my-secret --from-literal=PASSWORD=12345
```

Use in Pod:

```yaml
envFrom:
  - secretRef:
      name: my-secret
```

---

## 🧮 7. Scaling

### Manual Scaling

```bash
kubectl scale deployment my-deployment --replicas=5
```

### Horizontal Pod Autoscaler (HPA)

Automatically scales based on CPU usage.

```bash
minikube addons enable metrics-server
kubectl autoscale deployment my-deployment --cpu-percent=50 --min=1 --max=10
kubectl get hpa
```

---

## 🔁 8. Rolling Updates & Rollbacks

### Update Image:

```bash
kubectl set image deployment/my-deployment my-container=myimage:v2
```

### Rollback:

```bash
kubectl rollout undo deployment/my-deployment
```

### Status:

```bash
kubectl rollout status deployment/my-deployment
```

---

## 💾 9. Storage (Basics)

### Persistent Volume (PV) & Persistent Volume Claim (PVC)

Used for storing data permanently (e.g., database files).

* **PV:** actual storage resource
* **PVC:** user request for storage

---

## 📦 10. Namespaces

Used to separate environments or teams.

```bash
kubectl create namespace dev
kubectl get namespaces
kubectl apply -f deployment.yaml -n dev
```

---

## 🚀 11. Useful Minikube Commands

| Command                                 | Description             |
| --------------------------------------- | ----------------------- |
| `minikube start`                        | Start the cluster       |
| `minikube stop`                         | Stop the cluster        |
| `minikube status`                       | Check cluster status    |
| `minikube dashboard`                    | Open web dashboard      |
| `minikube service <svc-name> --url`     | Get external access URL |
| `minikube addons enable metrics-server` | Enable HPA metrics      |

---

## 🧹 12. Cleanup Commands

```bash
kubectl delete all --all            # Delete all objects
kubectl delete deployment my-deployment
kubectl delete svc my-deployment
kubectl delete namespace dev
minikube delete
```

---

## 💬 Interview Quick Answers

**Q1:** What is a Pod?

> Smallest deployable unit in Kubernetes — runs one or more containers.

**Q2:** How does a Deployment differ from a Pod?

> Deployment manages multiple replicas and handles rolling updates.

**Q3:** What is a Service?

> Abstract layer exposing Pods internally or externally.

**Q4:** What is the role of `kube-scheduler`?

> Assigns Pods to suitable Nodes based on resource availability.

**Q5:** How does autoscaling work?

> Uses metrics (like CPU %) to increase/decrease Pod replicas automatically.

**Q6:** How do you access your app in Minikube?

> Using `minikube service <service-name> --url`.

---
