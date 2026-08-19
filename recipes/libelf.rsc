NAME="libelf"
VERSION="0.8.13"
DEPENDS=""
URL="https://fossies.org/linux/misc/old/libelf-0.8.13.tar.gz"

build() {
    ./configure \
        --prefix=/usr \
        --libdir=/usr/lib \
        --sysconfdir=/etc \
        --enable-shared \
        --disable-nls

    make -j$(nproc)
    make install
}