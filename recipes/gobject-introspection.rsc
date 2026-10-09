# Recipe for gobject-introspection
NAME="gobject-introspection"
VERSION="1.86"
DEPENDS=""
URL="https://download.gnome.org/sources/gobject-introspection/1.86/gobject-introspection-1.86.0.tar.xz"
UPSTREAM_SOURCE=""

build() {

	meson setup build \
		--prefix=/usr \
		--buildtype=release

	ninja -C build -j8
	DESTDIR="$BUILD_ROOT" ninja -C build install
}

