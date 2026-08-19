# Recipe for binutils
NAME="binutils"
VERSION="1.0.0"
DEPENDS=""
URL="https://example.com/source/binutils-1.0.0.tar.gz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}
