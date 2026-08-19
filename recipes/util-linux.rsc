NAME="util-linux"
VERSION="2.40.2"
DEPENDS="ncurses zlib"
URL="https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.40/util-linux-2.40.2.tar.xz"

build() {
    # Ensure tty group exists in the build environment
    grep -q '^tty:' /etc/group || echo "tty:x:5:" >> /etc/group

    find . -exec touch {} +

    ./configure \
        --prefix=/usr \
        --bindir=/usr/bin \
        --sbindir=/usr/sbin \
        --libdir=/usr/lib \
        --disable-dependency-tracking \
        --disable-nls \
        --disable-liblastlog2 \
        --disable-use-tty-group \
        --disable-wall \
        --disable-chfn-chsh \
        --disable-login \
        --disable-su \
        --disable-runuser \
        --disable-pylibmount \
        --disable-static \
        --without-python \
        --without-systemd \
        --without-systemdsystemunitdir

    touch aclocal.m4 configure Makefile.in

    make -j$(nproc) AUTOCONF="true" AUTOMAKE="true" AUTOHEADER="true" ACLOCAL="true"
    make install AUTOCONF="true" AUTOMAKE="true" AUTOHEADER="true" ACLOCAL="true"
}