# Recipe for libwebp
NAME="libwebp"
VERSION="1.6.0"
DEPENDS="autoconf"
URL="https://github.com/webmproject/libwebp/archive/refs/tags/v1.6.0.tar.gz"
UPSTREAM_SOURCE="https://github.com/webmproject/libwebp.git"

build() {
    cmake -B build -G Ninja \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DCMAKE_INSTALL_LIBDIR=lib \
		-DCMAKE_BUILD_TYPE=Release
	
    ninja -C build
    DESTDIR="$BUILD_ROOT" ninja -C build install
}

