# Recipe for xf86-video-fbdev
NAME="xf86-video-fbdev"
VERSION="0.5.0"
DEPENDS=""
URL="https://www.x.org/pub/individual/driver/xf86-video-fbdev-0.5.0.tar.bz2"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

