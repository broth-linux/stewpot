# Recipe for cairomm
NAME="cairomm"
VERSION="1.14.5"
DEPENDS="cairo libsigc++ mm-common"
URL="https://cairographics.org/releases/cairomm-1.14.5.tar.xz"
UPSTREAM_SOURCE=""

build() {
	meson setup build \
		--prefix=/usr \
		--libdir=/usr/lib \
		--buildtype=release \
		-Dbuild-documentation=false \
		-Dbuild-tests=false \
		-Dbuild-examples=false
		
	ninja -C build -j$(nproc)
	DESTDIR="$BUILD_ROOT" ninja -C build install
}

