# Recipe for dbus
NAME="dbus"
VERSION="1.16.2"
DEPENDS=""
URL="https://dbus.freedesktop.org/releases/dbus/dbus-1.16.2.tar.xz"
UPSTREAM_SOURCE=""

build() {
	meson setup build \
		--prefix=/usr \
		--buildtype=release \
		--wrap-mode=nofallback \
		--default-library=both \
		-D systemd=disabled 
	ninja -C build
	DESTDIR="$BUILD_ROOT" ninja -C build install
	
}

