NAME="grub"
VERSION="2.12"
DEPENDS=""
URL="https://ftp.gnu.org/gnu/grub/grub-2.12.tar.xz"

build() {
    # Configure for 64-bit UEFI targets
    ./configure \
        --prefix=/usr \
        --sbindir=/usr/bin \
        --sysconfdir=/etc \
        --disable-werror \
        --disable-nls \
        --with-platform=efi \
        --target=x86_64

    make -j$(nproc)
    make install
}