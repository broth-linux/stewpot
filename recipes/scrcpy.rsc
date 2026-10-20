# Recipe for scrcpy
NAME="scrcpy"
VERSION="2.7"
DEPENDS="ffmpeg sdl2 libusb openssl zlib"
URL="https://github.com/Genymobile/scrcpy/archive/refs/tags/v${VERSION}.tar.gz"
UPSTREAM_SOURCE="https://github.com/Genymobile/scrcpy.git"

build() {

	meson setup build \
		--prefix=/usr \
		--buildtype=release \
		-Dcompile_server=false \
		-Dprebuilt_server=../scrcpy-server

	ninja -C build -j$(nproc)
	DESTDIR="$BUILD_ROOT" ninja -C build install

}

