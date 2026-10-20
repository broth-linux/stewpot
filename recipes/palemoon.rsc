# Recipe for palemoon
NAME="palemoon"
VERSION="35.0.2"
DEPENDS=""
URL="https://wmlive.rumbero.org/repo/pool/main/p/palemoon/palemoon_35.0.2-0wmlive0.tar.gz"
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
