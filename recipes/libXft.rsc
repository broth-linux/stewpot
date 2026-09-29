# Recipe for libXft
NAME="libXft"
VERSION="2.3.9"
DEPENDS=""
URL="https://xorg.freedesktop.org/releases/individual/lib/libXft-2.3.9.tar.xz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

