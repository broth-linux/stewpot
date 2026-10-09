# Recipe for parted
NAME="parted"
VERSION="3.6"
DEPENDS=""
URL="https://ftp.gnu.org/gnu/parted/parted-3.6.tar.xz"
UPSTREAM_SOURCE="https://git.savannah.gnu.org/git/parted.git"

build() {

	export CFLAGS="$CFLAGS -D_GNU_SOURCE"
	
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --enable-shared \
        --disable-static \
        --disable-rpath \
        --disable-nls \
        --disable-device-mapper \
        --without-readline

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

