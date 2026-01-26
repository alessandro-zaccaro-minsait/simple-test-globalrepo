#!/usr/bin/env bash
set -euo pipefail

# Node build
export CI=true
npm --version || true
node --version || true

# nessuna dipendenza esterna; se ne servono, aggiungi un package-lock e usa `npm ci`
npm test
mkdir -p build
npm run build
