# Recipe for curl
NAME="curl"
VERSION="8.9.1"
DEPENDS=""
URL="https://curl.se/download/curl-8.9.1.tar.xz"

build() {
	export CC="gcc"
	export CFLAGS="-O2"

    ./configure \
        --prefix=/usr \
	--with-openssl \
	--with-zlib \
	--disable-manual \
	--disable-docs \
	--disable-nls


    make
    make install
	
}
