# Recipe for cairo
NAME="cairo"
VERSION="1.18.6"
DEPENDS=""
URL="https://www.cairographics.org/releases/cairo-1.18.6.tar.xz"
UPSTREAM_SOURCE=""

build() {
	meson setup build \
		--prefix=/usr \
		--buildtype=release

	ninja -C build
	DESTDIR="$BUILD_ROOT" ninja -C build install

}

