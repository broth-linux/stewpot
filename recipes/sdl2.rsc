# Recipe for sdl2
NAME="sdl2"
VERSION="2.30.11"
DEPENDS=""
URL="https://github.com/libsdl-org/SDL/releases/download/release-${VERSION}/SDL2-${VERSION}.tar.gz"
UPSTREAM_SOURCE=""

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --enable-shared \
        --disable-static \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

