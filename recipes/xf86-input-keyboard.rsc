# Recipe for xf86-input-keyboard
NAME="xf86-input-keyboard"
VERSION="2.0.0"
DEPENDS=""
URL="https://www.x.org/pub/individual/driver/xf86-input-keyboard-2.0.0.tar.xz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

