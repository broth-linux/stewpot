# Recipe for libXinerama
NAME="libXinerama"
VERSION="1.1.6"
DEPENDS=""
URL="https://xorg.freedesktop.org/releases/individual/lib/libXinerama-1.1.6.tar.xz"
UPSTREAM_SOURCE=""

build() {
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--mandir=/usr/share/man \
		--localstatedir=/var

	make -j$(nproc 2>/dev/null || echo 1)
	make DESTDIR="$BUILD_ROOT" install
}
