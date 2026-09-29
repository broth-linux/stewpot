# Recipe for setuptools
NAME="setuptools"
VERSION="75.8.0"
DEPENDS=""
URL="https://github.com/pypa/setuptools/archive/refs/tags/v75.8.0.tar.gz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}
