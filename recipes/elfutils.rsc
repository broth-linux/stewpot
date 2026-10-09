NAME="elfutils"
VERSION="0.191"
DEPENDS="zlib"
URL="https://sourceware.org/elfutils/ftp/0.191/elfutils-0.191.tar.bz2"

build() {

	export CFLAGS="$CFLAGS -DFNM_EXTMATCH=0"
	
    ./configure \
        --prefix=/usr \
        --bindir=/usr/bin \
        --libdir=/usr/lib \
        --disable-debuginfod \
        --disable-libdebuginfod \
        --disable-nls \
        --without-zstd \
        --without-lzma
        LDFLAGS="$LDFLAGS -lobstack"

    make -j$(nproc)
    make DESTDIR="$BUILD_ROOT" install
}
