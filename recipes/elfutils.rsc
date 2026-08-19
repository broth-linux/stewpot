NAME="elfutils"
VERSION="0.191"
DEPENDS="zlib"
URL="https://sourceware.org/elfutils/ftp/0.191/elfutils-0.191.tar.bz2"

build() {
    ./configure \
        --prefix=/usr \
        --bindir=/usr/bin \
        --libdir=/usr/lib \
        --disable-debuginfod \
        --disable-libdebuginfod \
        --disable-nls \
        --without-zstd \
        --without-lzma

    make -j$(nproc)
    make install
}