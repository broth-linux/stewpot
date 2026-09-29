# Recipe for mtdev
NAME="mtdev"
VERSION="1.1.6"
DEPENDS=""
URL="https://bitmath.org/code/mtdev/mtdev-1.1.6.tar.bz2"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

