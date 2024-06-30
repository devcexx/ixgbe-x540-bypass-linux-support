# Intel X540-T2BP IXGBE bypass feature support

## What?

This repository holds a set of patches for the IXGBE Linux Kernel
driver for providing it support for the bypass feature available on
some Intel NICs. These patches have been mainly derived from the [DPDK
IXGBE
driver](https://github.com/DPDK/dpdk/tree/c15902587b538ff02cfb0fbb4dd481f1503d936b/drivers/net/ixgbe)
and the [FreeBSD IXGBE
driver](https://github.com/freebsd/freebsd-src/tree/9738277b5c662a75347efa6a58daea485d30f895/sys/dev/ixgbe)
implementations (they don't necessarily support this feature for
X540-based NICs, but the way it works is exactly the same than in
others).

The bypass feature is a feature that allows some 10 Gbit Intel network
cards with two RJ45 ports to put themselves in a state where the ports
are physically attached together, effectively allowing the traffic to
flow from one port to another without going through the NIC, even when
it is powered off. This feature may be useful for building networks
that goes through the card without a need of an extra switch (I don't
know, maybe ring networks or something?) and making sure they don't
fail if the server where they are attached to does.

This repository includes patches to make sure the X540-T2BP network
card is catched by the IXGBE driver and exposes the bypass feature
through sysfs, to be managed from the userspace. Even though the
bypass feature is supported on more NICs, this repository only focuses
on the X540 because it is the one I have at home and I can use for
testing.

This driver is not intended for production use, since it lacks
important things like concurrency controls.

## Building

Fully download this repository with: `git clone --recursive <repo
path>`.  The command will download the repository alongside the Linux
kernel and Busybox (for testing).

Then, run `make apply-patches` to apply the patches over the current
Kernel commit.

Finally, run `make build-dev-kernel` to build the kernel. The build
config is optimized for fast building and to be ran on a QEMU
virtual machine. Config is located at `dev/kernel-dev-config` and
can be customized.

## Testing

Testing is done in a QEMU virtual machine, an this repository holds a
couple of scripts to make testing easier and faster.

Firstly, make sure you have installed all the QEMU required packages. In
ArchLinux, these are the following:
 - qemu-base
 - qemu-common
 - qemu-hw-usb-host
 - qemu-img
 - qemu-system-x86
 - qemu-system-x86-firmware
 
Secondly, navigate to the `dev/run-virt.sh` and make the necessary
changes to perform a PCI passthrough of the network card you want to
test with from your host machine to the virtual machine. Some guidance
[here](https://wiki.gentoo.org/wiki/GPU_passthrough_with_libvirt_qemu_kvm).
 
Finally, run `make build-and-run`, which will run anther the hood the
targets `build-dev-kernel`, `build-dev-initramfs` for generating a
boot image with Busybox, and then `run-dev-machine` which will just
run the QEMU emulator.
 
## Developing

Once you've ran the `make apply-patches` command, you may start coding
on top of the latest commit under the linux/ folder. Once you're done,
commit the changes and run `make build-patches`. That will create one
patch file per new commit in the patches/ folder.
