# Recipe for mkfontscale
NAME="mkfontscale"
VERSION="1.2.3"
DEPENDS=""
URL="https://www.x.org/pub/individual/app/mkfontscale-1.2.3.tar.xz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

