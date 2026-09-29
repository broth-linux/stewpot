# Recipe for libdrm
NAME="libdrm"
VERSION="2.4.112"
DEPENDS=""
URL="https://dri.freedesktop.org/libdrm/libdrm-2.4.112.tar.xz"
UPSTREAM_SOURCE=""

build() {
	meson setup build \
		--prefix=/usr \
		--buildtype=release \
		-Dudev=true \
		-Dvalgrind=false
ninja -C build
ninja -C build install

}

