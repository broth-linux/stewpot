# Recipe for libexpat
NAME="libexpat"
VERSION="2.8.5"
DEPENDS=""
URL="https://github.com/libexpat/libexpat/releases/download/R_2_8_5/expat-2.8.5.tar.xz"
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

