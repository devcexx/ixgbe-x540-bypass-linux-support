git_base_path="$(git rev-parse --show-toplevel)"

qemu-system-x86_64 \
    -machine q35 \
    -kernel "$git_base_path/linux/arch/x86_64/boot/bzImage" \
    -initrd "$git_base_path/dev/initramfs/initramfs-busybox.img" \
    -append "console=ttyS0 verbose loglevel=7" \
    -nodefaults \
    -netdev user,id=net0 \
    -usb -device usb-kbd \
    -device ahci,id=ahci \
    -enable-kvm \
    -cpu host -m 4G -smp cores=8 \
    -device pcie-root-port,id=pciport.1,bus=pcie.0,slot=1,multifunction=on \
    -device pcie-root-port,id=pciport.2,bus=pcie.0,slot=2 \
    -device e1000,bus=pciport.2,netdev=net0 \
    -chardev stdio,id=s1,signal=off \
    -serial none -device isa-serial,chardev=s1 \
    -device qemu-xhci \
    -display none
