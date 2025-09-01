#!/usr/bin/env bash
set -euo pipefail

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

echo "[i] Aguardando métricas aparecerem..."
sleep 10
kubectl top nodes || true
kubectl top pods -A || true

# Se o 'top' não mostrar valores depois de ~1min, descomente o patch abaixo:
# kubectl patch deployment metrics-server -n kube-system --type='json' -p='[
#   {"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-insecure-tls"},
#   {"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname"}
# ]'