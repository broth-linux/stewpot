# Recipe for libXfixes
NAME="libXfixes"
VERSION="6.0.2"
DEPENDS=""
URL="https://xorg.freedesktop.org/archive/individual/lib/libXfixes-6.0.2.tar.xz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

