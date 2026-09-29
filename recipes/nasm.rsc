# Recipe for nasm
NAME="nasm"
VERSION="3.02"
DEPENDS=""
URL="https://www.nasm.us/pub/nasm/releasebuilds/3.02/nasm-3.02.tar.xz"
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

