# Recipe for xkeyboard-config
NAME="xkeyboard-config"
VERSION="2.41"
DEPENDS=""
URL="https://www.x.org/pub/individual/data/xkeyboard-config/xkeyboard-config-2.41.tar.xz"

build() {
    meson setup build \
	--prefix=/usr \
	--buildtype=release
    ninja -C build
    DESTDIR="$BUILD_ROOT" ninja -C build install
    
}

