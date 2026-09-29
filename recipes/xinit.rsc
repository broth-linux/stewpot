# Recipe for xinit
NAME="xinit"
VERSION="1.4.2"
DEPENDS=""
URL="https://www.x.org/pub/individual/app/xinit-1.4.2.tar.xz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

