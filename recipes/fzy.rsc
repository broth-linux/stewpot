# Recipe for fzy
NAME="fzy"
VERSION="1.1"
DEPENDS=""
URL="https://github.com/jhawthorn/fzy/archive/refs/tags/v1.1.tar.gz"
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

