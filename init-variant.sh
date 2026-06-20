#!/usr/bin/env bash
# init-variant.sh — scaffold a new acreetionos variant from the template
# usage:
#   ./init-variant.sh my-cool-build          # unofficial variant
#   ./init-variant.sh kde-edition official    # official variant
#   ./init-variant.sh --list                  # list existing variants

set -e

TEMPLATE_DIR="variants/_template"
BASE_DIR="$(dirname "$(readlink -f "$0")")"

list_variants() {
    echo "=== official variants ==="
    find variants/official -mindepth 1 -maxdepth 1 -type d 2>/dev/null | sed 's|variants/official/||' || echo "  (none)"
    echo ""
    echo "=== unofficial variants ==="
    find variants/unofficial -mindepth 1 -maxdepth 1 -type d 2>/dev/null | sed 's|variants/unofficial/||' || echo "  (none)"
}

if [ "$1" = "--list" ] || [ "$1" = "-l" ]; then
    list_variants
    exit 0
fi

if [ -z "$1" ]; then
    echo "usage: ./init-variant.sh <name> [official|unofficial]"
    echo "       ./init-variant.sh --list"
    echo ""
    echo "examples:"
    echo "  ./init-variant.sh hyprland-edition"
    echo "  ./init-variant.sh kde-edition official"
    exit 1
fi

VARIANT_NAME="$1"
TIER="${2:-unofficial}"

if [ "$TIER" != "official" ] && [ "$TIER" != "unofficial" ]; then
    echo "error: tier must be 'official' or 'unofficial'"
    exit 1
fi

VARIANT_DIR="variants/${TIER}/${VARIANT_NAME}"

if [ -d "$VARIANT_DIR" ]; then
    echo "error: variant '$VARIANT_NAME' already exists in $TIER/"
    exit 1
fi

echo "  scaffolding new $TIER variant: $VARIANT_NAME"

# copy template
cp -r "$TEMPLATE_DIR" "$VARIANT_DIR"

# replace placeholders
sed -i "s|{{VARIANT_NAME}}|$VARIANT_NAME|g" "$VARIANT_DIR/README.md"
sed -i "s|iso_name=\"AcreetionOS-Variant\"|iso_name=\"AcreetionOS-${VARIANT_NAME}\"|g" "$VARIANT_DIR/profiledef.sh"
sed -i "s|iso_label=\"acreetionOS_var_|iso_label=\"acreetionOS_${VARIANT_NAME}_|g" "$VARIANT_DIR/profiledef.sh"

echo "  variant scaffolded at $VARIANT_DIR"
echo ""
echo "  next steps:"
echo "    1. edit $VARIANT_DIR/profiledef.sh   (iso name, version, branding)"
echo "    2. edit $VARIANT_DIR/packages.x86_64  (add/remove packages)"
echo "    3. drop custom files into $VARIANT_DIR/airootfs/"
echo "    4. run: ./build.sh $VARIANT_NAME"
echo ""
echo "  happy building uwu"
