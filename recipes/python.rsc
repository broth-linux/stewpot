# Recipe for python
NAME="python"
VERSION="3.14.7"
DEPENDS=""
URL="https://python.org/ftp/python/3.14.7/Python-3.14.7.tar.xz"

build() {
    ./configure \
        --prefix=/usr \
        --with-ensurepip=install 

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}
