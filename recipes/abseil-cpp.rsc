# Recipe for abseil-cpp
NAME="abseil-cpp"
VERSION="20240116.2"
DEPENDS=""
URL="https://github.com/abseil/abseil-cpp/archive/refs/tags/20240116.2.tar.gz"
UPSTREAM_SOURCE="https://github.com/abseil/abseil-cpp.git"

build() {
	cmake -B build -G Ninja \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_CXX_STANDARD=17 \
		-DCMAKE_POSITION_INDEPENDENT_CODE=ON  \
		-DABSL_PROPAGATE_CXX_STD=ON  \
		-DBUILD_SHARED_LIBS=ON

	
    ninja -C build -j$(nproc 2>/dev/null || echo 1)
    DESTDIR="$BUILD_ROOT" ninja -C build install
}

