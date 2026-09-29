# Recipe for libxcb
NAME="libxcb"
VERSION="1.17.0"
DEPENDS=""
URL="https://xorg.freedesktop.org/archive/individual/lib/libxcb-1.17.0.tar.xz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
	--enable-xinput \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

