# Recipe for st
NAME="st"
VERSION="0.9.2"
DEPENDS=""
URL="https://dl.suckless.org/st/st-0.9.2.tar.gz"

build() {
#    ./configure \
#        --prefix=/usr \
#        --sysconfdir=/etc \
#        --mandir=/usr/share/man \
#        --localstatedir=/var

#    make -j$(nproc 2>/dev/null || echo 1)
#    make DESTDIR="$BUILD_ROOT" install
make
make DESTDIR="$BUILD_ROOT" install
}

