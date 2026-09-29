# Recipe for fribidi
NAME="fribidi"
VERSION="1.0.17"
DEPENDS=""
URL="https://github.com/fribidi/fribidi/releases/download/v1.0.17/fribidi-1.0.17.tar.xz"
UPSTREAM_SOURCE=""

build() {

	meson setup build \
		--prefix=/usr \
		--buildtype=release

	ninja -C build
	DESTDIR="$BUILD_ROOT" ninja -C build install

}

