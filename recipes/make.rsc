# Recipe for make
NAME="make"
VERSION="4.4.1"
DEPENDS=""
URL="https://ftp.gnu.org/gnu/make/make-4.4.1.tar.gz"

build() {
    export CFLAGS="$CFLAGS -static"
    ./configure \
        --prefix=/usr \
        --host=x86_64-linux-musl \
        --disable-nls \
        --without-guile

    make
    make DESTDIR="/mnt/broth" install
}