# Recipe for libevdev
NAME="libevdev"
VERSION="1.13.1"
DEPENDS=""
URL="https://www.freedesktop.org/software/libevdev/libevdev-1.13.1.tar.xz"

build() {
 meson setup build \
	--prefix=/usr \
	--buildtype=release \
	-Dtests=disabled \
	-Ddocumentation=disabled

	ninja -C build
	DESTDIR="$BUILD_ROOT" ninja -C build install


}

