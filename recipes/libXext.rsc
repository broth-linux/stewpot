# Recipe for libXext
NAME="libXext"
VERSION="1.3.6"
DEPENDS=""
URL="https://xorg.freedesktop.org/archive/individual/lib/libXext-1.3.6.tar.xz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
	--disable-specs \
	--disable-static \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

