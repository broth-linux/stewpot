# Recipe for bitch
NAME="bitch"
VERSION="99.99.87"
DEPENDS="assholes"
URL="https://www.yourmother.prg/archive/suckmyballs.tar.gz"
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
