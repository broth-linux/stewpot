# Recipe for libXi
NAME="libXi"
VERSION="1.8"
DEPENDS=""
URL="https://xorg.freedesktop.org/releases/individual/lib/libXi-1.8.tar.gz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

