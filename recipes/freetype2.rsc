# Recipe for freetype2
NAME="freetype2"
VERSION="2.14.3"
DEPENDS=""
URL="https://downloads.sourceforge.net/freetype/freetype-2.14.3.tar.xz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

