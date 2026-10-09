# Recipe for gdk-pixbuf
NAME="gdk-pixbuf"
VERSION="2.42.10"
DEPENDS=""
URL="https://download.gnome.org/sources/gdk-pixbuf/2.42/gdk-pixbuf-2.42.10.tar.xz"
UPSTREAM_SOURCE=""

build() {
	# Neutralize the thumbnailer subdir in the root meson.build
	sed -i "s/subdir('thumbnailer')/# subdir('thumbnailer')/" meson.build

	# Force meson into the else block (empty array) for loaders.cache
	sed -i 's/if not meson.is_cross_build()/if false/' gdk-pixbuf/meson.build

	
	# Supply zlib for libpng symbols without breaking sanity checks
	unset LDFLAGS
			
	meson setup build \
		--prefix=/usr \
		--libdir=/usr/lib \
		--buildtype=release \
		-Dgio_sniffing=false \
		-Dintrospection=disabled \
		-Dinstalled_tests=false \
		-Dtiff=disabled \
		-Dman=false \
		-Dbuiltin_loaders=none \
		-Dman=false \
		-Dtests=false \
		-Dpng=enabled \
		-Djpeg=enabled \
		--wrap-mode=nofallback

	ninja -C build -j$(nproc)
	DESTDIR="$BUILD_ROOT" ninja -C build install
}

