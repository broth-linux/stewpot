# Recipe for mtools
NAME="mtools"
VERSION="4.0.44"
DEPENDS=""
URL="https://ftp.gnu.org/gnu/mtools/mtools-${VERSION}.tar.bz2"
UPSTREAM_SOURCE=""

build() {
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--without-x

	make -j$(nproc 2>/dev/null || echo 1)
	make DESTDIR="$BUILD_ROOT" install
}
