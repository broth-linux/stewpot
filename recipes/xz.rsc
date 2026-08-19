NAME="xz"
VERSION="5.6.2"
DEPENDS=""
URL="https://github.com/tukaani-project/xz/releases/download/v5.6.2/xz-5.6.2.tar.gz"

build() {
    export CC="gcc"
    export CFLAGS="-O2"

    ./configure \
        --prefix=/usr \
        --disable-nls \
        --disable-static \
        --docdir=/usr/share/doc/xz-5.6.2

    make -j$(nproc)
    make install
}