# Recipe for openssl
NAME="openssl"
VERSION="3.2.1"
DEPENDS="zlib"
URL="https://www.openssl.org/source/openssl-3.2.1.tar.gz"

build() {
    ./config \
        --prefix=/usr \
        --openssldir=/etc/ssl \
	--libdir=lib \
	shared \
	zlib \
	no-async \
	no-tests

    make -j$(nproc)
    make install_sw
}
