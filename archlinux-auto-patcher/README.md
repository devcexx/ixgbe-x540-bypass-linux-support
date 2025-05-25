# Auto "Patcher" for Arch Linux

Since it is quite unconvenient for me to keep rebuilding the kernel I
use everyday just for including the patches held in this repo, this
folder contains an utility that uses a pacman hook to automatically
download the latest installed Arch Linux kernel source, patch it, and
build only the ixgbe kernel driver. Then it will be installed,
replacing the original ixgbe driver, effectively making an out-of-tree
module (yes, it will also taint the kernel). As for now I've focused
on making it work with the default Arch Linux kernel (package name
`linux`).

Just install the package by running `makepkg -si` and it will
automatically start applying the patches published in this repository
every time the linux kernel and its headers are updated.
