# Recipe for xcb-util
NAME="xcb-util"
VERSION="0.4.1"
DEPENDS=""
URL="https://xcb.freedesktop.org/dist/xcb-util-0.4.1.tar.xz"
UPSTREAM_SOURCE=""

	

build() {

	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--libdir=/usr/lib \
		--localstatedir=/var

	make -j$(nproc 2>/dev/null || echo 1)
	make DESTDIR="$BUILD_ROOT" install
}
