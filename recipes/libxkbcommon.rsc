# Recipe for libxkbcommon
NAME="libxkbcommon"
VERSION="1.13.1"
DEPENDS="xkeyboard-config"
URL="https://github.com/xkbcommon/libxkbcommon/archive/refs/tags/xkbcommon-${VERSION}.tar.gz"
UPSTREAM_SOURCE="https://github.com/xkbcommon/libxkbcommon.git"

build() {
	meson setup build \
		--prefix=/usr \
		-Denable-wayland=false \
		-Ddefault_library=both \
		--sysconfdir=/etc \
		--libdir=lib \
		--buildtype=release \
		--localstatedir=/var

	ninja -C build -j$(nproc 2>/dev/null || echo 1)
	DESTDIR="$BUILD_ROOT" ninja -C build install
}
