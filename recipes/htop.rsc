# Recipe for htop
NAME="htop"
VERSION="3.3.0"
DEPENDS=""
URL="https://github.com/htop-dev/htop/releases/download/3.3.0/htop-3.3.0.tar.xz"

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
