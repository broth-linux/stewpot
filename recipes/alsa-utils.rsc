# Recipe for alsa-utils
NAME="alsa-utils"
VERSION="1.2.9"
DEPENDS="alsa-lib ncurses"
URL="https://www.alsa-project.org/files/pub/utils/alsa-utils-1.2.9.tar.bz2"
UPSTREAM_SOURCE="https://github.com/alsa-project/alsa-utils.git"

build() {
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var \
		--with-udev-rules-dir=/usr/lib/udev/rules.d \
		--disable-alsaconf \
		--disable-bat \
		--disable-xmlto \
		--disable-rst2man \
		--with-curses-ncurses

	make -j$(nproc 2>/dev/null || echo 1)
	make DESTDIR="$BUILD_ROOT" install
}
