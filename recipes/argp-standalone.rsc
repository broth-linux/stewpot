NAME="argp-standalone"
VERSION="1.4.1"
DEPENDS=""
URL="https://github.com/jahid-rafee/argp-standalone/archive/refs/tags/v1.4.1.tar.gz"

build() {
    ./configure --prefix=/usr
    make -j$(nproc)
    mkdir -p /usr/include /usr/lib
    cp -v argp.h /usr/include/
    cp -v libargp.a /usr/lib/
}