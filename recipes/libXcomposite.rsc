# Recipe for libXcomposite
NAME="libXcomposite"
VERSION="0.4.6"
DEPENDS="libXdamage xorgproto"
URL="https://www.x.org/releases/individual/lib/libXcomposite-0.4.6.tar.xz"
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

