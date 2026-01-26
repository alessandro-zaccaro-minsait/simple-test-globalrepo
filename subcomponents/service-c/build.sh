#!/usr/bin/env bash
set -euo pipefail

python3 --version || true
# Nessuna dipendenza esterna per l'esempio
python3 -m unittest -v
mkdir -p build
python3 app.py > build/output.txt
