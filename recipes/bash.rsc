NAME="bash"
VERSION="5.2.21"
DEPENDS="ncurses"
URL="https://ftp.gnu.org/gnu/bash/bash-5.2.21.tar.gz"

build() {
    ./configure \
        --prefix=/usr \
        --bindir=/usr/bin \
        --without-bash-malloc \
        --with-curses \
        --disable-nls

    make -j$(nproc)
    make install
}