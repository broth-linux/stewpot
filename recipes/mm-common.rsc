# Recipe for mm-common
NAME="mm-common"
VERSION="1.0.8"
DEPENDS=""
URL="https://github.com/GNOME/mm-common/archive/refs/tags/1.0.8.tar.gz"
UPSTREAM_SOURCE="https://github.com/GNOME/mm-common/mm-common.git"

build() {
	meson setup build \
	--prefix=/usr \
	--sysconfdir=/etc \
	--localstatedir=/var \
	--buildtype=release

	ninja -C build -j$(nproc 2>/dev/null || echo 1)
	DESTDIR="$BUILD_ROOT" ninja -C build install
}

