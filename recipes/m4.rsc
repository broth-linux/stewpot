# Recipe for m4
NAME="m4"
VERSION="1.4.21"
DEPENDS=""
URL="https://ftp.gnu.org/gnu/m4/m4-1.4.21.tar.xz"

build() {
    export CFLAGS="$CFLAGS -static"
    ./configure \
        --prefix=/usr

    make
    make DESTDIR="$BUILD_ROOT" install
}
