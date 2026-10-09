# Recipe for gcc
NAME="gcc"
VERSION="16.2.0"
DEPENDS="gawk perl"
URL="https://ftp.gnu.org/gnu/gcc/gcc-${VERSION}/gcc-${VERSION}.tar.xz"
UPSTREAM_SOURCE=""

build() {

	export LC_ALL=C
	export LANG=C
	export AWK=/usr/bin/gawk
	./contrib/download_prerequisites

	sudo rm -f gcc/options.cc gcc/options.h && sudo rm -rf build && mkdir -p build && cd build
	
	../configure \
		AWK=/usr/bin/gawk \
        --prefix=/usr \
        --enable-languages=c,c++ \
        --disable-multilib \
        --disable-bootstrap \
        --disable-nls \
        --enable-threads=posix \
        --sysconfdir=/etc \
		--with-system-zlib

    make AWK=/usr/bin/gawk -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install-strip
}

