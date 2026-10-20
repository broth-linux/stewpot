# Recipe for gmplib
NAME="gmplib"
VERSION="6.3.0"
DEPENDS=""
URL="https://gmplib.org/download/gmp/gmp-6.3.0.tar.xz"
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
