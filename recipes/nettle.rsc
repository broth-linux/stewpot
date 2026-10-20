# Recipe for nettle
NAME="nettle"
VERSION="3.10.1"
DEPENDS=""
URL="https://ftp.gnu.org/gnu/nettle/nettle-4.0.tar.gz"
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
