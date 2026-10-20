# Recipe for lz4
NAME="lz4"
VERSION="1.9.4"
DEPENDS=""
URL="https://github.com/lz4/lz4/archive/refs/tags/v1.9.4.tar.gz"
UPSTREAM_SOURCE="https://github.com/lz4/lz4.git"

build() {

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

