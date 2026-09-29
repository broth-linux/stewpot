# Recipe for mdadm
NAME="mdadm"
VERSION="4.6"
DEPENDS=""
URL="https://git.kernel.org/pub/scm/utils/mdadm/mdadm.git/snapshot/mdadm-4.6.tar.gz"
UPSTREAM_SOURCE=""

build() {
    make CC="${CC:-gcc}" CXFLAGS="-D_GNU_SOURCE" CWFLAGS="-Wno-error" NO_UDEV=1 NO_SYSTEMD=1 -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" BINDIR=/usr/sbin  install-bin
}

