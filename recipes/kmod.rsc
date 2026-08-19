NAME="kmod"
VERSION="32"
DEPENDS="zlib"
URL="https://mirrors.edge.kernel.org/pub/linux/utils/kernel/kmod/kmod-32.tar.xz"

build() {
    # Clear any leftover links that cause install-exec-hook to fail
    rm -f /usr/bin/insmod /usr/bin/lsmod /usr/bin/rmmod /usr/bin/depmod /usr/bin/modprobe /usr/bin/modinfo

    ./configure \
        --prefix=/usr \
        --bindir=/usr/bin \
        --libdir=/usr/lib \
        --sysconfdir=/etc \
        --with-zlib \
        --disable-manpages

    make -j$(nproc)
    make install
}