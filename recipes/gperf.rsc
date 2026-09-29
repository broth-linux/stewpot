# Recipe for gperf
NAME="gperf"
VERSION="3.1"
DEPENDS=""
URL="https://ftp.gnu.org/gnu/gperf/gperf-3.1.tar.gz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

