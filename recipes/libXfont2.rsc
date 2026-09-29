# Recipe for libXfont2
NAME="libXfont2"
VERSION="2.0.7"
DEPENDS=""
URL="https://www.x.org/pub/individual/lib/libXfont2-2.0.7.tar.xz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

