#!/usr/bin/env bash
# Regenerate initramfs explicitly — the mkinitcpio post-transaction hook
# segfaults in the pacstrap chroot, so we run it here via arch-chroot
# where /proc, /sys, and /dev are properly mounted.
set -e -u

mkinitcpio -p linux
