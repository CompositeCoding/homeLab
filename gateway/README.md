Storing the YAML of the NGINX Gateway locally for reference.

kubectl kustomize "https://github.com/nginx/nginx-gateway-fabric/config/crd/gateway-api/standard?ref=v2.2.1" | kubectl apply -f -

kubectl apply --server-side -f https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/v2.2.1/deploy/crds.yaml

kubectl apply -f https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/v2.2.1/deploy/nodeport/deploy.yaml
