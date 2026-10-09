# Recipe for musl-obstack
NAME="musl-obstack"
VERSION="1.2.3"
DEPENDS=""
URL="https://github.com/void-linux/musl-obstack/archive/refs/tags/v1.2.3.tar.gz"
UPSTREAM_SOURCE=""

build() {
	./bootstrap.sh
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

