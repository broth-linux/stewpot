# Recipe for dialog
NAME="dialog"
VERSION="1.3-20240619"
sDEPENDS="ncurses"
URL="https://invisible-island.net/archives/dialog/dialog-1.3-20240619.tgz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
	--with-ncursesw \
	--enable-widec \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

