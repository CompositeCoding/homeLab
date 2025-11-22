#!/bin/bash
kubectl get pods -n argocd | grep "argocd-server" | awk '{print $1}' | xargs -I {} kubectl port-forward pod/{} 8080
