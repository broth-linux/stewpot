# Recipe for libressl
NAME="libressl"
VERSION="4.4.0rc1"
DEPENDS=""
URL="https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-4.4.0rc1.tar.gz"
UPSTREAM_SOURCE="https://github.com/libressl/portable.git"

build() {
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--mandir=/usr/share/man \
		--localstatedir=/var

	make -j$(nproc 2>/dev/null || echo 1)
	make DESTDIR="$BUILD_ROOT" install
}
