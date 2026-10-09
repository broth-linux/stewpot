# Recipe for gparted
NAME="gparted"
VERSION="1.6.0"
DEPENDS="parted gtkmm3"
URL="https://downloads.sourceforge.net/gparted/gparted-1.6.0.tar.gz"
UPSTREAM_SOURCE="https://gitlab.gnome.org/GNOME/gparted.git"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --disable-doc \
        --disable-nls

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

