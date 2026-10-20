# Recipe for brotli
NAME="brotli"
VERSION="1.1.0"
DEPENDS=""
URL="https://github.com/google/brotli/archive/refs/tags/v1.1.0.tar.gz"
UPSTREAM_SOURCE="https://github.com/google/brotli.git"

build() {

	cmake -B build -G Ninja \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DCMAKE_BUILD_TYPE=Release \
		-DBUILD_SHARED_LIBS=ON

    ninja -C build -j$(nproc 2>/dev/null || echo 1)
    DESTDIR="$BUILD_ROOT" ninja -C build install
}

