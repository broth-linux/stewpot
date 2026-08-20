# Installing Broth Linux

This guide covers installing Broth Linux onto a target drive using the official root filesystem tarball.

---

## 1. Prepare Storage and Partitions

Identify your target disk (e.g., `/dev/sda` or `/dev/nvme0n1`) and create your partitions (GPT layout recommended):
* **Partition 1:** EFI System Partition (FAT32, ~512MB)
* **Partition 2:** Root Partition (ext4, remainder of drive)

Format the partitions:
```sh
mkfs.vfat -F32 /dev/sdX1
mkfs.ext4 /dev/sdX2
```

Mount the root partition and target directories:
```sh
mount /dev/sdX2 /mnt
mkdir -p /mnt/boot
mount /dev/sdX1 /mnt/boot
```

---

## 2. Extract the Rootfs Tarball

Download and extract the latest Broth Linux release archive into the new root:
```sh
cd /mnt
tar -xpvf /path/to/broth-rootfs-*.tar.gz -C /mnt
```

---

## 3. Enter the Chroot Environment

Bind mount the virtual filesystems:
```sh
mount --bind /dev /mnt/dev
mount --bind /proc /mnt/proc
mount --bind /sys /mnt/sys
mount --bind /run /mnt/run
```

Copy DNS resolution and chroot into the installation:
```sh
cp /etc/resolv.conf /mnt/etc/resolv.conf
chroot /mnt /bin/sh
```

---

## 4. System Configuration

Inside the chroot:

1. **Set Hostname:**
   ```sh
   echo "broth-box" > /etc/hostname
   ```

2. **Set Root Password:**
   ```sh
   passwd
   ```

3. **Verify Kernel and Bootloader:**
   Ensure `/boot/vmlinuz` is in place, then install your preferred bootloader (such as GRUB, Syslinux, or EFISTUB) pointing root to `/dev/sdX2`.

---

## 5. Exit and Reboot

```sh
exit
umount -R /mnt
reboot
```

Once booted, use `stewpot` to build packages and manage your system.
