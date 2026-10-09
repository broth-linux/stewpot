# Recipe for libxcvt
NAME="libxcvt"
VERSION="0.1.3"
DEPENDS=""
URL="https://www.x.org/pub/individual/lib/libxcvt-0.1.3.tar.xz"

build() {
	meson setup build \
		--prefix=/usr \
		--buildtype=release

	ninja -C build
	DESTDIR="$BUILD_ROOT" ninja -C build install
}

