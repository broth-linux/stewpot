# Recipe for dhcpcd
NAME="dhcpcd"
VERSION="10.5.2"
DEPENDS=""
URL="https://github.com/NetworkConfiguration/dhcpcd/archive/refs/tags/v10.5.2.tar.gz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}
