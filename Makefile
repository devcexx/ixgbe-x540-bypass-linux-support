.PHONY:
build-dev-kernel:
	cd linux && $(MAKE) -j20 KCONFIG_CONFIG=../dev/kernel-dev-config bzImage modules

.PHONY:
build-dev-initramfs:
	dev/initramfs/build-initramfs.sh

.PHONY:
run-dev-machine:
	dev/run-virt.sh

.PHONY:
build-and-run: build-dev-kernel build-dev-initramfs run-dev-machine

.PHONY:
build-patches:
	dev/build-patches.sh

.PHONY:
apply-patches:
	dev/apply-patches.sh
