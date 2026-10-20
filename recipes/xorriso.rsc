# Recipe for xorriso
NAME="xorriso"
VERSION="1.5.6.pl02"
DEPENDS=""
URL="https://www.gnu.org/software/xorriso/xorriso-1.5.6.pl02.tar.gz"
UPSTREAM_SOURCE=""

build() {
	./configure \
		--prefix=/usr \
		--disable-static \
		--enable-shared

	make -j$(nproc 2>/dev/null || echo 1)
	make DESTDIR="$BUILD_ROOT" install
}
