# Recipe for openbox
NAME="openbox"
VERSION="3.6.0"
DEPENDS="libX11 glib libxml2 pango"
URL="git+https://github.com/Mikachu/openbox.git"
UPSTREAM_SOURCE="https://github.com/Mikachu/openbox.git"

build() {
	./bootstrap
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--datarootdir=/usr/share \
		--libdir=/usr/lib

	make -j$(nproc 2>/dev/null || echo 1)
	make DESTDIR="$BUILD_ROOT" install
}
