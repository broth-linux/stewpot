# Recipe for protobuf
NAME="protobuf"
VERSION="25.3"
DEPENDS="zlib abseil-cpp"
URL="https://github.com/protocolbuffers/protobuf/releases/download/v25.3/protobuf-25.3.tar.gz"
UPSTREAM_SOURCE="https://github.com/protocolbuffers/protobuf.git"

build() {
	cmake -B build -G Ninja \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DCMAKE_BUILD_TYPE=Release \
		-DBUILD_SHARED_LIBS=ON \
		-Dprotobuf_BUILD_TESTS=OFF \
		-Dprotobuf_ABSL_PROVIDER=package \
		-DCMAKE_CXX_STANDARD=17


	ninja -C build -j$(nproc 2>/dev/null || echo 1)
    DESTDIR="$BUILD_ROOT" ninja -C build install
}

