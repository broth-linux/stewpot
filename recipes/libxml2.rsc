# Recipe for libxml2
NAME="libxml2"
VERSION="2.14.5"
DEPENDS=""
URL="https://download.gnome.org/sources/libxml2/2.14/libxml2-2.14.5.tar.xz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

