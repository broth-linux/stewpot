# Recipe for gawk
NAME="gawk"
VERSION="5.4.1"
DEPENDS=""
URL="https://ftp.gnu.org/gnu/gawk/gawk-5.4.1.tar.xz"
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

