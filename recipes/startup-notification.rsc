# Recipe for startup-notification
NAME="startup-notification"
VERSION="0.12"
DEPENDS=""
URL="https://freedesktop.org/software/startup-notification/releases/startup-notification-${VERSION}.tar.gz"
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
