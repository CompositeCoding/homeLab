You need to create a secret.yaml and manually apply it.

Eventually I'll setup sealed secrets.

---
apiVersion: v1
kind: Secret
metadata:
  name: operator-oauth
  namespace: tailscale
stringData:
  client_id:
  client_secret:
