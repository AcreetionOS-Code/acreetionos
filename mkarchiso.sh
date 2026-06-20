#!/usr/bin/env bash
set -euo pipefail

NPROC=$(nproc)
export MAKEFLAGS="-j${NPROC}"
export PACMAN_OPTS="--overwrite '*'"
export XZ_OPT="-T${NPROC}"

mkarchiso -L AcreetionOS_XL -v -o ../ISO . -C ./pacman.conf
