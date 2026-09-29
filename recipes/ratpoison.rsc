# Recipe for ratpoison
NAME="ratpoison"
VERSION="1.4.9"
DEPENDS=""
URL="https://download.savannah.nongnu.org/releases/ratpoison/ratpoison-1.4.9.tar.xz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
	--without-xrandr \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

