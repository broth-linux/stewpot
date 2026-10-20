# Recipe for dropbear
NAME="dropbear"
VERSION="2026.91"
DEPENDS=""
URL="https://dropbear.nl/mirror/releases/dropbear-2026.91.tar.bz2"
UPSTREAM_SOURCE="https://github.com/mkj/dropbear.git"

build() {
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--mandir=/usr/share/man \
		--localstatedir=/var

	make -j$(nproc 2>/dev/null || echo 1)
	make DESTDIR="$BUILD_ROOT" install
}
