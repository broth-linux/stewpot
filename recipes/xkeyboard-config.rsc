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
    ninja -C build install
    
}

