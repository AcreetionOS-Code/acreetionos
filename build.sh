 #!/usr/bin/env bash
set -euo pipefail

NPROC=$(nproc)
export MAKEFLAGS="-j${NPROC}"
export PACMAN_OPTS="--overwrite '*'"

./refresh.sh
./mkarchiso.sh
sudo rm -rf ./work

