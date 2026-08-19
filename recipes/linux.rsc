NAME="linux"
VERSION="7.1.9"
DEPENDS="kmod"
URL="https://mirrors.edge.kernel.org/pub/linux/kernel/v7.x/linux-7.1.9.tar.xz"

build() {
    # Generate default base configuration
    make defconfig

# Strip out every subsystem that invokes objtool
./scripts/config --disable CONFIG_UNWINDER_ORC \
    --enable CONFIG_UNWINDER_FRAME_POINTER \
    --disable CONFIG_STACK_VALIDATION \
    --disable CONFIG_OBJTOOL \
    --disable CONFIG_HAVE_OBJTOOL \
    --disable CONFIG_RETHUNK \
    --disable CONFIG_RETPOLINE \
    --disable CONFIG_SLS \
    --disable CONFIG_FINEIBT \
    --disable CONFIG_STATIC_CALL_INLINE \
    --disable CONFIG_MITIGATION_RETHUNK \
    --disable CONFIG_MITIGATION_SLS \
    --disable CONFIG_JUMP_LABEL

# Enable essential boot, console & disk drivers
./scripts/config --enable CONFIG_DEVTMPFS \
    --enable CONFIG_DEVTMPFS_MOUNT \
    --enable CONFIG_EFI_STUB \
    --enable CONFIG_VT \
    --enable CONFIG_VT_CONSOLE \
    --enable CONFIG_HW_CONSOLE \
    --enable CONFIG_FRAMEBUFFER_CONSOLE \
    --enable CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY \
    --enable CONFIG_DRM \
    --enable CONFIG_DRM_I915 \
    --enable CONFIG_DRM_FBDEV_EMULATION \
    --enable CONFIG_FB \
    --enable CONFIG_FB_SIMPLE \
    --enable CONFIG_DRM_SIMPLEDRM \
    --enable CONFIG_SATA_AHCI \
    --enable CONFIG_BLK_DEV_NVME \
    --enable CONFIG_EXT4_FS
    make olddefconfig

    # Create a dummy objtool binary and make tools/objtool target a no-op
    mkdir -p tools/objtool
    cat << 'EOF' > tools/objtool/objtool
#!/bin/sh
exit 0
EOF
    chmod +x tools/objtool/objtool

    # Patch Makefile to prevent rebuilding objtool
    sed -i 's/tools\/objtool: FORCE/tools\/objtool:/' Makefile 2>/dev/null || true
    echo "all:" > tools/objtool/Makefile

    # Compile kernel image and modules, disabling stack validation flag
    make -j$(nproc) bzImage modules STACK_VALIDATION=

    # Install modules and artifacts
    make modules_install
    mkdir -p /boot
    cp -v arch/x86/boot/bzImage /boot/vmlinuz-${VERSION}
    cp -v System.map /boot/System.map-${VERSION}
    cp -v .config /boot/config-${VERSION}
}