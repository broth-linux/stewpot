# Recipe for xf86-input-evdev
NAME="xf86-input-evdev"
VERSION="2.10.6"
DEPENDS=""
URL="https://www.x.org/pub/individual/driver/xf86-input-evdev-2.10.6.tar.bz2"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
	--disable-mtdev \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

