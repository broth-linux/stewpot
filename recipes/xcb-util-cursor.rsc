# Recipe for xcb-util-cursor
NAME="xcb-util-cursor"
VERSION="0.1.3"
DEPENDS="xcb-util"
URL="https://xcb.freedesktop.org/dist/xcb-util-cursor-${VERSION}.tar.bz2"
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
