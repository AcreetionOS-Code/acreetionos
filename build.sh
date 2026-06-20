#!/usr/bin/env bash
# build.sh — build acreetionos ISO, with optional variant support
# usage:
#   ./build.sh                  # build base acreetionos
#   ./build.sh my-cool-build    # build unofficial variant
#   ./build.sh kde-edition official  # build official variant

set -e

VARIANT_NAME="$1"
VARIANT_TIER="${2:-unofficial}"
VARIANT_DIR=""

if [ -n "$VARIANT_NAME" ]; then
    # try unofficial first, then official
    if [ -d "variants/unofficial/$VARIANT_NAME" ]; then
        VARIANT_DIR="variants/unofficial/$VARIANT_NAME"
    elif [ -d "variants/official/$VARIANT_NAME" ]; then
        VARIANT_DIR="variants/official/$VARIANT_NAME"
    else
        echo "error: variant '$VARIANT_NAME' not found in variants/unofficial/ or variants/official/"
        echo "run './init-variant.sh $VARIANT_NAME' to create it first"
        exit 1
    fi
    echo "  building variant: $VARIANT_NAME ($VARIANT_DIR)"
fi

# backup original files if building a variant
if [ -n "$VARIANT_DIR" ]; then
    cp profiledef.sh profiledef.sh.bak
    cp packages.x86_64 packages.x86_64.bak

    # merge variant profiledef (variant values override base)
    echo "  merging variant profiledef.sh..."
    while IFS='=' read -r key value; do
        key=$(echo "$key" | xargs)
        if [ -n "$key" ] && [[ ! "$key" =~ ^# ]] && [[ "$key" =~ ^[a-zA-Z_] ]]; then
            # only override if the key exists in base
            if grep -q "^$key=" profiledef.sh; then
                sed -i "s|^$key=.*|$key=$value|" profiledef.sh
            fi
        fi
    done < "$VARIANT_DIR/profiledef.sh"

    # append variant packages (excluding comments and blank lines)
    echo "  merging variant packages..."
    grep -v '^#' "$VARIANT_DIR/packages.x86_64" | grep -v '^$' >> packages.x86_64

    # merge airootfs overlay
    if [ -d "$VARIANT_DIR/airootfs" ] && [ "$(ls -A "$VARIANT_DIR/airootfs" 2>/dev/null)" ]; then
        echo "  merging variant airootfs overlay..."
        cp -r "$VARIANT_DIR/airootfs/"* airootfs/ 2>/dev/null || true
    fi
fi

echo "  cleaning workspace and building ISO..."
./refresh.sh -j && ./mkarchiso.sh

# move ISO to variant-specific output dir
if [ -n "$VARIANT_NAME" ]; then
    ISO_DIR="../ISO/$VARIANT_NAME"
    mkdir -p "$ISO_DIR"
    if [ -d out ]; then
        mv out/*.iso "$ISO_DIR/" 2>/dev/null || true
        echo "  ISO output to $ISO_DIR"
    fi
fi

# restore backups
if [ -f profiledef.sh.bak ]; then
    mv profiledef.sh.bak profiledef.sh
    mv packages.x86_64.bak packages.x86_64
fi

# cleanup
sudo rm -rf ./work 2>/dev/null || true
echo "  done!"
