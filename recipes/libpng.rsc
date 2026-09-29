# Recipe for libpng
NAME="libpng"
VERSION="1.6.58"
DEPENDS="zlib"
URL="https://github.com/pnggroup/libpng/archive/refs/tags/v1.6.58.tar.gz"
UPSTREAM_SOURCE="https://github.com/pnggroup/libpng.git"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

