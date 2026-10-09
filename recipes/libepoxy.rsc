# Recipe for libepoxy
NAME="libepoxy"
VERSION="1.15.10"
DEPENDS=""
URL="https://github.com/anholt/libepoxy/archive/refs/tags/1.5.10.tar.gz"

build() {
    meson setup build \
        --prefix=/usr \
	--buildtype=release \
	-Degl=no \
	-Dglx=no \
	-Dtests=false


    ninja -C build
    DESTDIR="$BUILD_ROOT" ninja -C build install
}

