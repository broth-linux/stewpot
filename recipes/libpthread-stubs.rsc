# Recipe for libpthread-stubs
NAME="libpthread-stubs"
VERSION="0.5"
DEPENDS=""
URL="https://xorg.freedesktop.org/archive/individual/xcb/libpthread-stubs-0.5.tar.xz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

