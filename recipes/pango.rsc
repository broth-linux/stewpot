# Recipe for pango
NAME="pango"
VERSION="1.58"
DEPENDS=""
URL="https://download.gnome.org/sources/pango/1.58/pango-1.58.2.tar.xz"
UPSTREAM_SOURCE=""

build() {

	meson setup build \
		--prefix=/usr \
		--buildtype=release \
		--wrap-mode=nofallback \
		-D introspection=disabled

	ninja -C build
	DESTDIR="$BUILD_ROOT" ninja -C build install
}

