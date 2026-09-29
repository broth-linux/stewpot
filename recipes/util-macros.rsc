# Recipe for util-macros
NAME="util-macros"
VERSION="1.20.0"
DEPENDS=""
URL="https://www.x.org/pub/individual/util/util-macros-1.20.0.tar.xz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

