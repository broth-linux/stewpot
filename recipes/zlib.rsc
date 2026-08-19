# Recipe for zlib
NAME="zlib"
VERSION="1.3.2"
DEPENDS=""
URL="https://zlib.net/zlib-1.3.2.tar.gz"

build() {
    ./configure \
     --prefix=/usr

    make -j8
    make install
}