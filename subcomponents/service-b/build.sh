#!/usr/bin/env bash
set -euo pipefail

mvn -v || true
mvn -B -DskipTests=false clean verify
