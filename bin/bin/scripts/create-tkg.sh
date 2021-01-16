#!/bin/dash

objcopy \
    --add-section .osrel="/usr/lib/os-release" --change-section-vma .osrel=0x20000 \
    --add-section .cmdline="kernel-command-line.txt" --change-section-vma .cmdline=0x30000 \
    --add-section .linux="vmlinuz-linux510-tkg-upds" --change-section-vma .linux=0x2000000 \
    --add-section .initrd="initramfs-linux510-tkg-upds.img" --change-section-vma .initrd=0x3000000 \
    "/usr/lib/systemd/boot/efi/linuxx64.efi.stub" "linux-tkg.efi"
mv linux-tkg.efi ./EFI/Linux/linux-tkg.efi -v
