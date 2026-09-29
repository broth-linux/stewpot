# Recipe for glib
NAME="glib"
VERSION="2.90.0"
DEPENDS=""
URL="https://download.gnome.org/sources/glib/2.90/glib-2.90.0.tar.xz"
UPSTREAM_SOURCE=""

build() {

	meson setup build \
		--prefix=/usr \
		--buildtype=release \
		--default-library=both \
		-Dintrospection=enabled \
		-Dlibmount=disabled \
		-Dsysprof=disabled \
		-Dglib_debug=disabled

	ninja -C build -j8
	DESTDIR="$BUILD_ROOT" ninja -C build install

}

