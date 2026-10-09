# Recipe for dbus
NAME="dbus"
VERSION="1.16.2"
DEPENDS="curl libX11 libexpat openssl zlib"
URL="https://dbus.freedesktop.org/releases/dbus/dbus-1.16.2.tar.xz"
UPSTREAM_SOURCE=""

build() {
	meson setup build \
		--prefix=/usr \
		--buildtype=release \
		--wrap-mode=nofallback \
		--default-library=both \
		-Dc_args="-I/usr/include" \
		-Dc_link_args="-L/usr/lib" \
		-Dxml_docs=disabled \
		$(meson_flavor SYSTEMD systemd) \
		$(meson_flavor X11 x11_autolaunch) || return 1
	ninja -C build || return 1
	DESTDIR="$BUILD_ROOT" ninja -C build install
	
}

