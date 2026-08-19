NAME="ncurses"
VERSION="6.4"
DEPENDS=""
URL="https://ftp.gnu.org/gnu/ncurses/ncurses-6.4.tar.gz"

build() {
    export CC="gcc"
    export CXX="g++"
    export AR="ar"
    export RANLIB="ranlib"
    export NM="nm"
    export CFLAGS="-O2 -fPIC"
    export CXXFLAGS="-O2 -fPIC"

    ./configure \
        --prefix=/usr \
        --mandir=/usr/share/man \
        --with-shared \
        --without-debug \
        --without-ada \
        --without-cxx-binding \
        --without-normal \
        --enable-widec \
        --enable-pc-files \
        --with-pkg-config-libdir=/usr/lib/pkgconfig

    make -j$(nproc) AR="ar"
    make install

    # Create non-wide symlinks for compatibility
    for lib in ncurses form panel menu; do
        ln -sf lib${lib}w.so /usr/lib/lib${lib}.so
        ln -sf lib${lib}w.a /usr/lib/lib${lib}.a 2>/dev/null || true
        ln -sf ${lib}w.pc /usr/lib/pkgconfig/${lib}.pc 2>/dev/null || true
    done
    ln -sf /usr/include/ncursesw /usr/include/ncurses 2>/dev/null || true
}