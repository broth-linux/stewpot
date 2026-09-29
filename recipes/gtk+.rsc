# Recipe for gtk+
NAME="gtk+"
VERSION="3.0.12"
DEPENDS=""
URL="https://download.gnome.org/sources/gtk+/3.0/gtk%2B-3.0.12.tar.xz"
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

