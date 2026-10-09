# Recipe for libXcursor
NAME="libXcursor"
VERSION="1.2.2"
DEPENDS="libX11 libXrender libXfixes"
URL="https://www.x.org/releases/individual/lib/libXcursor-1.2.2.tar.xz"
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

