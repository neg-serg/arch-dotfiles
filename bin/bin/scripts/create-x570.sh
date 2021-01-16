#!/bin/dash
objcopy \
    --add-section .osrel="/usr/lib/os-release" --change-section-vma .osrel=0x20000 \
    --add-section .cmdline="kernel-command-line-x570-vfio-openrgb.txt" --change-section-vma .cmdline=0x30000 \
    --add-section .linux="vmlinuz-linux-x570-vfio-openrgb" --change-section-vma .linux=0x2000000 \
    --add-section .initrd="initramfs-linux-x570-vfio-openrgb.img" --change-section-vma .initrd=0x3000000 \
    "/usr/lib/systemd/boot/efi/linuxx64.efi.stub" "linux.efi"
mv linux.efi ./EFI/Linux/linux.efi -v
