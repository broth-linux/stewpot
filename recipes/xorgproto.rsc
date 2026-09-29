# Recipe for xorgproto
NAME="xorgproto"
VERSION="2024.1"
DEPENDS=""
URL="https://www.x.org/pub/individual/proto/xorgproto-2024.1.tar.xz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

