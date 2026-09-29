# Recipe for xkbcomp
NAME="xkbcomp"
VERSION="1.5.0"
DEPENDS=""
URL="https://xorg.freedesktop.org/archive/individual/app/xkbcomp-1.5.0.tar.xz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

