# Recipe for libtool
NAME="libtool"
VERSION="2.6.2"
DEPENDS=""
URL="https://ftp.gnu.org/gnu/libtool/libtool-2.6.2.tar.xz"
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

