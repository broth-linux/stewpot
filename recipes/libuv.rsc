# Recipe for libuv
NAME="libuv"
VERSION="1.53.0"
DEPENDS=""
URL="https://dist.libuv.org/dist/v1.53.0/libuv-v1.53.0.tar.gz"
UPSTREAM_SOURCE=""

build() {
	./autogen.sh
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--disable-static \
		--localstatedir=/var

	make -j$(nproc 2>/dev/null || echo 1)
	make DESTDIR="$BUILD_ROOT" install
}
