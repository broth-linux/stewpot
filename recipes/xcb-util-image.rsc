# Recipe for xcb-util-image
NAME="xcb-util-image"
VERSION="0.4.0"
DEPENDS="xcb-util"
URL="https://xcb.freedesktop.org/dist/xcb-util-image-${VERSION}.tar.bz2"
UPSTREAM_SOURCE=""

build() {
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--mandir=/usr/share/man \
		--localstatedir=/var

	make -j$(nproc 2>/dev/null || echo 1)
	make DESTDIR="$BUILD_ROOT" install
}
