# Recipe for font-misc-misc
NAME="font-misc-misc"
VERSION="1.1.3"
DEPENDS=""
URL="https://www.x.org/pub/individual/font/font-misc-misc-1.1.3.tar.xz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

