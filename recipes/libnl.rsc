# Recipe for libnl
NAME="libnl"
VERSION="3.9.0"
DEPENDS=""
URL="https://github.com/thom311/libnl/releases/download/libnl3_9_0/libnl-3.9.0.tar.gz"
UPSTREAM_SOURCE=""

build() {
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--disable-static \
		--disable-pki

	make -j$(nproc 2>/dev/null || echo 1)
	make DESTDIR="$BUILD_ROOT" install
}
