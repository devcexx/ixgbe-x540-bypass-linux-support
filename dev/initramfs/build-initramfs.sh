#!/bin/bash
set -euo pipefail

git_base_path="$(git rev-parse --show-toplevel)"
base_path="$git_base_path/dev/initramfs"
rootfs_path="$base_path/rootfs"
busybox_path="$base_path/busybox"

rm -rf "$rootfs_path" || :
mkdir -p "$rootfs_path"

cp "$base_path/busybox-config" "$busybox_path"/.config
(cd "$busybox_path" && make -j$(nproc) && make CONFIG_PREFIX="$rootfs_path" install)

cp "$base_path/init" "$rootfs_path"
mkdir -p "$rootfs_path/depmod"
(cd "$git_base_path"/linux && make INSTALL_MOD_PATH="$rootfs_path/usr" INSTALL_MOD_STRIP=1 modules_install)

ln -sf usr/lib "$rootfs_path/lib"

(cd "$rootfs_path" && find . -print0 | cpio --null -ov --format=newc | gzip -9 > "$base_path/initramfs-busybox.img")
