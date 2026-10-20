# Recipe for rofi
NAME="rofi"
VERSION="2.0.0"
DEPENDS=""
URL="https://github.com/davatorium/rofi/releases/download/${VERSION}/rofi-${VERSION}.tar.xz"
UPSTREAM_SOURCE="https://github.com/davatorium/rofi.git"

build() {
	meson setup build \
		--prefix=/usr \
		--libdir=lib \
		-Dcheck=disabled \
		-Dwayland=disabled \
		-Dxcb=enabled
		

	ninja -C build -j$(nproc 2>/dev/null || echo 1)
	DESTDIR="$BUILD_ROOT" ninja -C build install
}
