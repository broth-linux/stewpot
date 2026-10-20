# Recipe for gettext
NAME="gettext"
VERSION="1.0"
DEPENDS=""
URL="https://ftp.gnu.org/pub/gnu/gettext/gettext-1.0.tar.gz"
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
