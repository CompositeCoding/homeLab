#!/bin/bash

# Kubectl Common Operations Examples

# Get cluster info
kubectl cluster-info

# Get all nodes
kubectl get nodes

# Get detailed node information
kubectl describe node talos-n4r-glu

# Get node resource usage
kubectl top nodes

# Get all namespaces
kubectl get namespaces

# Get all pods in all namespaces
kubectl get pods -A

# Get pods in specific namespace
kubectl get pods -n home

# Get detailed pod information
kubectl describe pod -n home nginx-6cf4c44fbd-fb54w

# Get pod logs
kubectl logs -n home nginx-6cf4c44fbd-fb54w

# Follow pod logs (stream)
kubectl logs -n home nginx-6cf4c44fbd-fb54w -f

# Get logs from previous container instance (if crashed)
kubectl logs -n home nginx-6cf4c44fbd-fb54w --previous

# Execute command in pod
kubectl exec -n home nginx-6cf4c44fbd-fb54w -- ls /usr/share/nginx/html

# Interactive shell in pod
kubectl exec -it -n home nginx-6cf4c44fbd-fb54w -- /bin/bash

# Get all services
kubectl get svc -A

# Get services in specific namespace
kubectl get svc -n home

# Get deployments
kubectl get deployments -A

# Scale deployment
kubectl scale deployment nginx -n home --replicas=3

# Get deployment status
kubectl rollout status deployment/nginx -n home

# Restart deployment (rolling restart)
kubectl rollout restart deployment/nginx -n home

# Get deployment history
kubectl rollout history deployment/nginx -n home

# Rollback deployment
kubectl rollout undo deployment/nginx -n home

# Get all resources in namespace
kubectl get all -n home

# Get pods with specific label
kubectl get pods -l app=nginx -n home

# Get pod resource usage
kubectl top pods -n home

# Port forward to access pod locally
kubectl port-forward -n home svc/nginx 8080:80

# Copy file to pod
kubectl cp ./local-file.txt home/nginx-6cf4c44fbd-fb54w:/tmp/file.txt

# Copy file from pod
kubectl cp home/nginx-6cf4c44fbd-fb54w:/tmp/file.txt ./local-file.txt

# Apply yaml configuration
kubectl apply -f deployment.yaml

# Delete resources
kubectl delete pod nginx-6cf4c44fbd-fb54w -n home

# Delete by file
kubectl delete -f deployment.yaml

# Get events in namespace
kubectl get events -n home --sort-by='.lastTimestamp'

# Get all events
kubectl get events -A --sort-by='.lastTimestamp'

# Get configmaps
kubectl get configmaps -n home

# Get secrets
kubectl get secrets -n home

# Decode secret
kubectl get secret my-secret -n home -o jsonpath='{.data.password}' | base64 -d

# Get persistent volumes
kubectl get pv

# Get persistent volume claims
kubectl get pvc -A

# Get storage classes
kubectl get storageclass

# Get ingress resources
kubectl get ingress -A

# Create namespace
kubectl create namespace my-namespace

# Delete namespace
kubectl delete namespace my-namespace

# Label a node
kubectl label nodes talos-n4r-glu gpu=nvidia

# Remove label from node
kubectl label nodes talos-n4r-glu gpu-

# Taint a node
kubectl taint nodes talos-n4r-glu key=value:NoSchedule

# Remove taint from node
kubectl taint nodes talos-n4r-glu key=value:NoSchedule-

# Cordon node (mark unschedulable)
kubectl cordon talos-n4r-glu

# Uncordon node (mark schedulable)
kubectl uncordon talos-n4r-glu

# Drain node (evict all pods for maintenance)
kubectl drain talos-n4r-glu --ignore-daemonsets

# Get api resources
kubectl api-resources

# Get current context
kubectl config current-context

# List all contexts
kubectl config get-contexts

# Switch context
kubectl config use-context my-context

# View merged kubeconfig
kubectl config view

# Get component status
kubectl get componentstatuses

# Run temporary pod for debugging
kubectl run -it --rm debug --image=busybox --restart=Never -- sh

# Run nginx for quick testing
kubectl run nginx --image=nginx --port=80

# Expose deployment as service
kubectl expose deployment nginx --port=80 --type=NodePort -n home

# Get yaml of existing resource
kubectl get deployment nginx -n home -o yaml

# Edit resource in place
kubectl edit deployment nginx -n home

# Patch resource
kubectl patch deployment nginx -n home -p '{"spec":{"replicas":2}}'

# Get resource with custom columns
kubectl get pods -n home -o custom-columns=NAME:.metadata.name,STATUS:.status.phase,IP:.status.podIP

# Get pods sorted by restart count
kubectl get pods -A --sort-by='.status.containerStatuses[0].restartCount'

# Get pods using JSONPath
kubectl get pods -n home -o jsonpath='{.items[*].metadata.name}'

# Check pod scheduling issues
kubectl get pods -A --field-selector=status.phase=Pending

