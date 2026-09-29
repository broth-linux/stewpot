# Recipe for lynx
NAME="lynx"
VERSION="1.0"
DEPENDS=""
URL="https://invisble-island.net/datafiles/release/lynx-cur.tar.gz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
		--enable-javascript \
		--with-ssl

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

