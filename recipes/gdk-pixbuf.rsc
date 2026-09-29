# Recipe for gdk-pixbuf
NAME="gdk-pixbuf"
VERSION="2.44"
DEPENDS=""
URL="https://download.gnome.org/sources/gdk-pixbuf/2.44/gdk-pixbuf-2.44.8.tar.xz"
UPSTREAM_SOURCE=""

build() {

	meson setup build \
		--prefix=/usr \
		--buildtype=release \
		-Dpng=disabled \
#		-Dloaders_cache_file=false \
		-Dgif=disabled \
		-Djpeg=disabled \
		-Dtiff=disabled \
		-Dthumbnailer=disabled \
		--wrap-mode=nofallback

	ninja -C build -j8
	ninja -C build install
}

