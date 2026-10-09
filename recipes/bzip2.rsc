# Recipe for bzip2
NAME="bzip2"
VERSION="1.0.8"
DEPENDS=""
URL="https://sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz"
UPSTREAM_SOURCE=""

build() {

    make -f Makefile-libbz2_so
   	make clean

   	make

   	make PREFIX="$BUILD_ROOT/usr" install

   	mkdir -p "$BUILD_ROOT/usr/lib"
   	cp -a libbz2.so* "$BUILD_ROOT/usr/lib/"
}

