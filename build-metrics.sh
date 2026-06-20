#!/usr/bin/env bash
set -euo pipefail

METRICS_FILE="build-metrics-$(date +%Y%m%d-%H%M%S).log"
START_TIME=$(date +%s)

log_metric() {
    local stage="$1"
    local elapsed=$(( $(date +%s) - START_TIME ))
    local elapsed_min=$(echo "scale=2; $elapsed / 60" | bc)
    echo "[$(date +%H:%M:%S)] [${elapsed}s / ${elapsed_min}m] ${stage}" | tee -a "$METRICS_FILE"
}

run_stage() {
    local stage="$1"
    shift
    log_metric "START: ${stage}"
    "$@"
    log_metric "END:   ${stage}"
}

if [ $# -eq 0 ]; then
    echo "Usage: $0 <command> [args...]"
    echo "Records elapsed time and logs build stage performance."
    echo
    echo "Example:"
    echo "  source build-metrics.sh"
    echo "  run_stage 'Building ISO' ./mkarchiso.sh"
    exit 0
fi

run_stage "$@"
