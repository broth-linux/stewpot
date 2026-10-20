# Recipe for libev
NAME="libev"
VERSION="4.33"
DEPENDS=""
URL="http://dist.schmorp.de/libev/Attic/libev-4.33.tar.gz"
UPSTREAM_SOURCE="https://github.com/enki/libev.git"

build() {
	./configure \
		--prefix=/usr \
		--disable-static \
		
	make -j$(nproc 2>/dev/null || echo 1)
	make DESTDIR="$BUILD_ROOT" install
}
