# Recipe for musl-fts
NAME="musl-fts"
VERSION="1.2.7"
DEPENDS=""
URL="https://github.com/void-linux/musl-fts/archive/refs/tags/v1.2.7.tar.gz"
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

