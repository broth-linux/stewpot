# Recipe for libXtst
NAME="libXtst"
VERSION="1.2.5"
DEPENDS=""
URL="https://xorg.freedesktop.org/releases/individual/lib/libXtst-1.2.5.tar.xz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

