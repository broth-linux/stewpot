# Recipe for xrandr
NAME="xrandr"
VERSION="1.5.4"
DEPENDS=""
URL="https://xorg.freedesktop.org/archive/individual/app/xrandr-1.5.4.tar.xz"
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

