# Recipe for libXdmcp
NAME="libXdmcp"
VERSION="1.1.5"
DEPENDS=""
URL="https://www.x.org/pub/individual/lib/libXdmcp-1.1.5.tar.xz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

