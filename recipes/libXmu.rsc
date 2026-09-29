# Recipe for libXmu
NAME="libXmu"
VERSION="1.3.1"
DEPENDS=""
URL="https://xorg.freedesktop.org/archive/individual/lib/libXmu-1.3.1.tar.xz"
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

