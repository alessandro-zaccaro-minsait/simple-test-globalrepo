#!/usr/bin/env bash
set -euo pipefail

go version || true

go test ./...
mkdir -p build
GOOS=linux GOARCH=amd64 go build -o build/service-d .
