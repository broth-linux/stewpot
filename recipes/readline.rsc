# Recipe for readline
NAME="readline"
VERSION="8.3"
DEPENDS=""
URL="ftp://ftp.gnu.org/gnu/readline/readline-8.3.tar.gz"
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
