# Recipe for wine
NAME="wine"
VERSION="11.0"
DEPENDS=""
URL="https://dl.winehq.org/wine/sources/11.0/wine-11.0.tar.xz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

