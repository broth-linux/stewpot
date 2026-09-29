# Recipe for imlib2
NAME="imlib2"
VERSION="1.12.7"
DEPENDS=""
URL="https://downloads.sourceforge.net/enlightenment/imlib2-1.12.7.tar.xz"
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

