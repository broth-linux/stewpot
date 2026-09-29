# Recipe for alsa-lib
NAME="alsa-lib"
VERSION="1.2.5.1"
DEPENDS=""
URL="https://ww.alsa-project.org/files/pub/lib/alsa-lib-1.2.5.1.tar.bz2"
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

