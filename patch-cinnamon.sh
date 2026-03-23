#!/bin/bash
# patch-cinnamon.sh
# Applying Cinnamon-AcreetionOS patches to airootfs.

set -e

echo "Applying Cinnamon patches to airootfs..."

# Create necessary directories in airootfs if they don't exist
mkdir -p airootfs/usr/bin
mkdir -p airootfs/usr/share

# Copy patched files from cinnamon-configs into the standard /usr tree.
# This ensures that mkarchiso includes these files in the ISO,
# effectively patching the official cinnamon packages.

if [ -d "airootfs/cinnamon-configs/cinnamon-stuff/usr" ]; then
    cp -rv airootfs/cinnamon-configs/cinnamon-stuff/usr/* airootfs/usr/
fi

if [ -d "airootfs/cinnamon-configs/cinnamon-stuff/bin" ]; then
    cp -rv airootfs/cinnamon-configs/cinnamon-stuff/bin/* airootfs/usr/bin/
fi

echo "Cinnamon patches applied successfully to airootfs."
