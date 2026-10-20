# Recipe for rsync
NAME="rsync"
VERSION="3.5.1"
DEPENDS=""
URL="https://github.com/RsyncProject/rsync/archive/refs/tags/v3.5.1.tar.gz"
UPSTREAM_SOURCE="https://github.com/RsyncProject/rsync.git"

build() {
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--disable-md2man \
		--disable-xxhash \
		--disable-idn \
		--localstatedir=/var

	make -j$(nproc 2>/dev/null || echo 1)
	make DESTDIR="$BUILD_ROOT" install
}
