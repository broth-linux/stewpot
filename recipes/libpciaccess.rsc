# Recipe for libpciaccess
NAME="libpciaccess"
VERSION="0.19"
DEPENDS=""
URL="https://xorg.freedesktop.org/archive/individual/lib/libpciaccess-0.19.tar.xz"

build() {
	meson setup build \
		--prefix=/usr \
		--buildtype=release

ninja -C build
ninja -C build install
}

