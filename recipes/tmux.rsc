# Recipe for tmux
NAME="tmux"
VERSION="3.5"
DEPENDS="libevent"
URL="https://github.com/tmux/tmux/releases/download/3.5a/tmux-3.5a.tar.gz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}
