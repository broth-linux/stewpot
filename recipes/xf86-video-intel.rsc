# Recipe for xf86-video-intel
NAME="xf86-video-intel"
VERSION="2.99.917"
DEPENDS=""
URL="https://xorg.freedesktop.org/archive/individual/driver/xf86-video-intel-2.99.917.tar.gz"
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

