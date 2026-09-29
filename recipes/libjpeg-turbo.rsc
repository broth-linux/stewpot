# Recipe for libjpeg-turbo
NAME="libjpeg-turbo"
VERSION="3.2.0"
DEPENDS="cmake ninja"
URL="https://github.com/libjpeg-turbo/libjpeg-turbo/archive/refs/tags/3.2.0.tar.gz"
UPSTREAM_SOURCE="https://github.com/libjpeg-turbo/libjpeg-turbo.git"

build() {
	cmake -B build -G Ninja \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DCMAKE_INSTALL_LIBDIR=lib \
		-DCMAKE_BUILD_TYPE=Release \
		-DWITH_JPEG8=1 \
		-DWITH-SIMD=0
	ninja -C build
	DESTDIR="$BUILD_ROOT" ninja -C build install
}

