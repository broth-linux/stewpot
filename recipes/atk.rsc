# Recipe for atk
NAME="atk"
VERSION="2.38"
DEPENDS=""
URL="https://download.gnome.org/sources/atk/2.38/atk-2.38.0.tar.xz"
UPSTREAM_SOURCE=""

build() {

	meson setup build \
		--prefix=/usr \
		--buildtype=release
	ninja -C build -j8
	DESTDIR="$BUILD_ROOT" ninja -C build install
}

