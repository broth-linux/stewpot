# Recipe for libtiff
NAME="libtiff"
VERSION="4.7.2"
DEPENDS=""
URL="https://gitlab.com/libtiff/libtiff/-/archive/v4.7.2/libtiff-v4.7.2.tar.gz"
UPSTREAM_SOURCE="https://gitlab.com/libtiff/libtiff.git"

build() {
#	./configure \
#	--prefix=/usr \
#	--disable-static
#
#	make
#	make DESTDIR="$BUILD_ROOT" install

	cmake -B build -G Ninja \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DCMAKE_INSTALL_LIBDIR=lib \
		-DCMAKE_BUILD_TYPE=Release
	ninja -C build
    DESTDIR="$BUILD_ROOT" ninja -C build install
}

