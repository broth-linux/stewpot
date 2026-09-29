# Recipe for giflib
NAME="giflib"
VERSION="5.2.1"
DEPENDS=""
URL="https://sourceforge.net/projects/giflib/files/giflib-5.2.1.tar.gz"
UPSTREAM_SOURCE=""

build() {
#    ./configure \
#       --prefix=/usr \
#        --sysconfdir=/etc \
#       --mandir=/usr/share/man \
#        --localstatedir=/var

    make PREFIX=/usr -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

