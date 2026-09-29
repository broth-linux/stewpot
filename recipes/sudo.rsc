# Recipe for sudo
NAME="sudo"
VERSION="1.9.15"
DEPENDS=""
URL="https://www.sudo.ws/dist/sudo-1.9.15p5.tar.gz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}
