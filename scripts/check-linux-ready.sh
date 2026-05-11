#!/usr/bin/env bash
set -euo pipefail

echo "== system =="
uname -a

echo
echo "== node =="
if command -v node >/dev/null 2>&1; then
  node -v
else
  echo "node: missing"
fi

echo
echo "== npm =="
if command -v npm >/dev/null 2>&1; then
  npm -v
else
  echo "npm: missing"
fi

echo
echo "== gpu =="
if command -v nvidia-smi >/dev/null 2>&1; then
  nvidia-smi
elif command -v rocm-smi >/dev/null 2>&1; then
  rocm-smi
else
  echo "No NVIDIA/ROCm GPU CLI detected. This package will run with the WASM fallback on Linux."
fi

echo
echo "== cuda toolkit =="
if command -v nvcc >/dev/null 2>&1; then
  nvcc --version | tail -1
elif [ -x /usr/local/cuda/bin/nvcc ]; then
  /usr/local/cuda/bin/nvcc --version | tail -1
else
  echo "nvcc: missing. Install CUDA Toolkit to build the CUDA miner:"
  echo "  sudo apt install nvidia-cuda-toolkit"
fi

echo
echo "== app =="
test -f package.json && echo "package.json: ok"
test -f hash256-cli.js && echo "hash256-cli.js: ok"
test -f .env && echo ".env: present" || echo ".env: missing; run: cp .env.example .env"
