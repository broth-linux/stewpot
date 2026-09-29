# Recipe for libSM
NAME="libSM"
VERSION="1.2.6"
DEPENDS=""
URL="https://xorg.freedesktop.org/archive/individual/lib/libSM-1.2.6.tar.xz"
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

