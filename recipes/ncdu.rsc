# Recipe for ncdu
NAME="ncdu"
VERSION="1.8"
DEPENDS="ncurses"
URL="git+https://github.com/rofl0r/ncdu.git"
UPSTREAM_SOURCE="https://github.com/rofl0r/ncdu.git"

build() {
	./autogen.sh
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--mandir=/usr/share/man \
		--localstatedir=/var

	make -j$(nproc 2>/dev/null || echo 1)
	make DESTDIR="$BUILD_ROOT" install
}
