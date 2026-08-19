NAME="nano"
VERSION="8.0"
DEPENDS="ncurses"
URL="https://www.nano-editor.org/dist/v8/nano-8.0.tar.xz"

build() {
    export CC="gcc"
    export AR="ar"
    export RANLIB="ranlib"
    export NM="nm"
    export CPPFLAGS="-I/usr/include/ncursesw -I/usr/include"
    export CFLAGS="-O2 -I/usr/include/ncursesw -I/usr/include"
    export LDFLAGS="-L/usr/lib"

    AR="ar" RANLIB="ranlib" ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --enable-utf8 \
        --disable-nls

    make -j$(nproc) AR="ar" RANLIB="ranlib"
    make install
}