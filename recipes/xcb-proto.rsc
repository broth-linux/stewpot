# Recipe for xcb-proto
NAME="xcb-proto"
VERSION="1.17.0"
DEPENDS=""
URL="https://xorg.freedesktop.org/archive/individual/proto/xcb-proto-1.17.0.tar.xz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

