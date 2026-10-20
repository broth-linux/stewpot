# Recipe for xcb-util-keysyms
NAME="xcb-util-keysyms"
VERSION="0.4.0"
DEPENDS="libxcb"
URL="https://xcb.freedesktop.org/dist/xcb-util-keysyms-${VERSION}.tar.bz2"
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
