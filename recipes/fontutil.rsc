# Recipe for fontutil
NAME="fontutil"
VERSION="1.4.2"
DEPENDS=""
URL="https://xorg.freedesktop.org/archive/individual/font/font-util-1.4.2.tar.xz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

