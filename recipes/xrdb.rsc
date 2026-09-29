# Recipe for xrdb
NAME="xrdb"
VERSION="1.2.3"
DEPENDS=""
URL="https://xorg.freedesktop.org/archive/individual/app/xrdb-1.2.3.tar.xz"
UPSTREAM_SOURCE=""

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

