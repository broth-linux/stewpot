# Recipe for libXrender
NAME="libXrender"
VERSION="0.9.12"
DEPENDS=""
URL="https://xorg.freedesktop.org/archive/individual/lib/libXrender-0.9.12.tar.xz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

