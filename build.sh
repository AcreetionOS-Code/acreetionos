#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/build-metrics.sh"

run_stage "Clean workspace" ./refresh.sh -j
run_stage "Build ISO" ./mkarchiso.sh
run_stage "Clean build artifacts" sudo rm -rf ./work

log_metric "BUILD COMPLETE"

