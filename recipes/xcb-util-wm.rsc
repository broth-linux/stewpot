# Recipe for xcb-util-wm
NAME="xcb-util-wm"
VERSION="0.4.2"
DEPENDS=""
URL="https://xcb.freedesktop.org/dist/xcb-util-wm-${VERSION}.tar.xz"
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
