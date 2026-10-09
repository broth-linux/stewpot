# Recipe for libXdamage
NAME="libXdamage"
VERSION="1.1.6"
DEPENDS="libXfixes xorgproto"
URL="https://www.x.org/releases/individual/lib/libXdamage-1.1.6.tar.xz"
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

