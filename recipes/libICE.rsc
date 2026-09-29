# Recipe for libICE
NAME="libICE"
VERSION="1.1.2"
DEPENDS=""
URL="https://xorg.freedesktop.org/archive/individual/lib/libICE-1.1.2.tar.xz"
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

