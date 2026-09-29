# Recipe for libXau
NAME="libXau"
VERSION="1.0.12"
DEPENDS=""
URL="https://www.x.org/pub/individual/lib/libXau-1.0.12.tar.xz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

