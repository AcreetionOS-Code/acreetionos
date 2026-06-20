#!/usr/bin/env bash
# shellcheck disable=SC2034
#
# VARIANT PROFILE OVERRIDE
# this file overrides the base profiledef.sh for this variant
# only include the fields you want to change — everything else falls back to base

# iso_name="VariantName"              # name of the ISO
# iso_label="variantOS_$(date...)"    # volume label (max 32 chars)
# iso_publisher="Variant Publisher"    # publisher string
# iso_application="Variant Install Media"  # application string
# iso_version="1.0"                   # version number
# install_dir="arch"                  # installation directory on ISO
# buildmodes=('iso')                  # build modes
# bootmodes=('bios.syslinux' 'uefi.grub')  # boot modes
# arch="x86_64"                       # architecture

# uncomment and customize these for your variant:
iso_name="AcreetionOS-Variant"
iso_label="acreetionOS_var_$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y%m)"
iso_publisher="Acreetion OS Community"
iso_application="Acreetion OS Variant Install Media"
iso_version="0.1.0"
