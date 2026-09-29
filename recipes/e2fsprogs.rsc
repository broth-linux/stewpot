# Recipe for e2fsprogs
NAME="e2fsprogs"
VERSION="1.47.1"
DEPENDS=""
URL="https://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v1.47.1/e2fsprogs-1.47.1.tar.xz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
	--enable-elf-shlibs \
	--disable-libuuid \
	--disable-libblkid \
	--disable-uuid \
	--disable-fsck

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

