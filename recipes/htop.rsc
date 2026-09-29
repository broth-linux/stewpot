# Recipe for htop
NAME="htop"
VERSION="3.5.0"
DEPENDS="ncurses"
URL="https://github.com/htop-dev/${NAME}/releases/download/${VERSION}/${NAME}-${VERSION}.tar.xz"
UPSTREAM_SOURCE="https://github.com/htop-dev/${NAME}.git"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --enable-unicode \
		--disable-sensors \
		--disable-affinity

    make -j$(nproc)
    make DESTDIR="$BUILD_ROOT" install
}
