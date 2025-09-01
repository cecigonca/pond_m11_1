#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="k3d-nginx-hpa"
K3D="./k3d/k3d.exe"; [ -x "$K3D" ] || K3D="k3d"

echo "[+] Creating cluster: $CLUSTER_NAME"
"$K3D" cluster create "$CLUSTER_NAME" \
  --servers 1 --agents 2 \
  -p "8080:80@loadbalancer"

echo "[+] Using context: k3d-$CLUSTER_NAME"
kubectl config use-context "k3d-$CLUSTER_NAME"

kubectl get nodes