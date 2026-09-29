# Recipe for libXrandr
NAME="libXrandr"
VERSION="1.5.5"
DEPENDS=""
URL="https://xorg.freedesktop.org/archive/individual/lib/libXrandr-1.5.5.tar.xz"
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

