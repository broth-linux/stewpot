# Recipe for geany
NAME="geany"
VERSION="2.0"
DEPENDS="gtk+3 glib harfbuzz pango cairo at-spi2-core glib gdk-pixbuf"
URL="https://download.geany.org/geany-2.0.tar.bz2"
UPSTREAM_SOURCE=""

build() {
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		$(conf_flavor gtk3) \
		$(conf_flavor nls)
		
	make -j$(nproc 2>/dev/null || echo 1)
	make DESTDIR="$BUILD_ROOT" install
}
