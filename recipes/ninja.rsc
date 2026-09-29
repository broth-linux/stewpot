# Recipe for ninja
NAME="ninja"
VERSION="1.12.1"
DEPENDS=""
URL="https://github.com/ninja-build/ninja/archive/refs/tags/v1.12.1.tar.gz"

build() {
    cmake -B build \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX=/usr \
	-DBUILD_TESTING=OFF

cmake --build build -j8
DESTDIR="$BUILD_ROOT" cmake --install build
}
