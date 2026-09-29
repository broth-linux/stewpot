# Recipe for xfsprogs
NAME="xfsprogs"
VERSION="7.2.0"
DEPENDS=""
URL="file:///var/cache/stew/sources/xfsprogs-7.2.0.tar.xz"
UPSTREAM_SOURCE=""

build() {
    ./configure \
        --prefix=/usr \
        --sbindir=/usr/sbin \
        --disable-libicu \
        --disable-nls \
        --disable-gettext \
        --disable-urcu \
        --disable-docs
    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" PKG_ROOT="$BUILD_ROOT" install install-dev
}

