#!/usr/bin/env bash
set -euo pipefail

DURATION=${1:-120s}
CONN=${2:-100}
URL=${3:-http://127.0.0.1:8080/}

if command -v hey >/dev/null 2>&1; then
  hey -z "$DURATION" -c "$CONN" "$URL"
else
  echo "[i] Rodando hey dentro do cluster (não precisa instalar localmente)"
  kubectl -n autoscale-demo run hey --rm -it --image=rakyll/hey --restart=Never -- \
    -z "$DURATION" -c "$CONN" "$URL"
fi