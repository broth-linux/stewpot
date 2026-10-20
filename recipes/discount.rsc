# Recipe for discount
NAME="discount"
VERSION="3.0.2.0"
DEPENDS=""
URL="https://pell.portland.or.us/~orc/Code/discount/discount-${VERSION}.tar.bz2"
UPSTREAM_SOURCE=""

build() {
	./configure.sh \
		--prefix=/usr \
		--enable-all-features

	make -j$(nproc 2>/dev/null || echo 1)
	make DESTDIR="$BUILD_ROOT" install
}
