# Recipe for xcb-util-renderutil
NAME="xcb-util-renderutil"
VERSION="0.3.10"
DEPENDS="libxcb"
URL="https://xcb.freedesktop.org/dist/xcb-util-renderutil-${VERSION}.tar.xz"
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
