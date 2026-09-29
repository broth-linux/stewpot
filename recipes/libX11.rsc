# Recipe for libX11
NAME="libX11"
VERSION="1.8.10"
DEPENDS=""
URL="https://xorg.freedesktop.org/archive/individual/lib/libX11-1.8.10.tar.xz"

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

