# Recipe for automake
NAME="automake"
VERSION="1.16.5"
DEPENDS="autoconf perl"
URL="https://ftp.gnu.org/gnu/automake/automake-1.16.5.tar.xz"
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

