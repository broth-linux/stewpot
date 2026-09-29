# Recipe for cbonsai
NAME="cbonsai"
VERSION="1.4.2"
DEPENDS="ncurses"
URL="https://gitlab.com/jallbrit/cbonsai/-/archive/v1.4.2/cbonsai-v1.4.2.tar.gz"
UPSTREAM_SOURCE="https://gitlab.com/jallbrit/cbonsai.git"

build() {
    make -j$(nproc 2>/dev/null || echo 1)
    make PREFIX=/usr DESTDIR="$BUILD_ROOT" install
}

