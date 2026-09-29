# Recipe for bdftopcf
NAME="bdftopcf"
VERSION="1.1"
DEPENDS=""
URL="https://xorg.freedesktop.org/archive/individual/app/bdftopcf-1.1.tar.gz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

