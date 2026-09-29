# Recipe for libudev
NAME="libudev"
VERSION="1.0.5"
DEPENDS=""
URL="https://github.com/illiliti/libudev-zero/archive/refs/tags/1.0.5.tar.gz"

build() {
	meson setup build \
	--prefix=/usr \
	--buildtype=release

ninja -C build
DESTDIR="$BUILD_ROOT" ninja -C build install

}

