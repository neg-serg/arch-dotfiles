#!/bin/dash

update_linux() {
    objcopy \
        --add-section .osrel="/usr/lib/os-release" --change-section-vma .osrel=0x20000 \
        --add-section .cmdline="kernel-command-line$linux_postfix.txt" --change-section-vma .cmdline=0x30000 \
        --add-section .linux="vmlinuz-linux$linux_postfix" --change-section-vma .linux=0x2000000 \
        --add-section .initrd="initramfs-linux$linux_postfix.img" --change-section-vma .initrd=0x3000000 \
        "/usr/lib/systemd/boot/efi/linuxx64.efi.stub" "linux$linux_postfix.efi"
    mv -v linux$linux_postfix.efi ./EFI/Linux/linux$linux_postfix.efi
}

case "$1" in
    rt) linux_postfix="-rt"; update_linux; exit 0 ;;
    *) linux_postfix=""; update_linux; exit 0 ;;
esac

