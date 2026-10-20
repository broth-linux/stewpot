# Recipe for android-tools
NAME="android-tools"
VERSION="34.0.5"
DEPENDS="zlib openssl zstd brotli protobuf"
URL="https://github.com/nmeum/android-tools/releases/download/34.0.5/android-tools-34.0.5.tar.xz"
UPSTREAM_SOURCE="https://github.com/nmeum/android-tools.git"

build() {
    cmake -B build -G Ninja \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DCMAKE_INSTALL_LIBDIR=lib \
		-DCMAKE_BUILD_TYPE=Release \
		-DBUILD_SHARED_LIBS=OFF \
		-DCMAKE_C_FLAGS="-D_GNU_SOURCE -DSEEK_DATA=3 -DSEEK_HOLE=4" \
		-DCMAKE_CXX_FLAGS="-D_GNU_SOURCE -DSEEK_DATA=3 -DSEEK_HOLE=4"
		

    ninja -C build -j$(nproc 2>/dev/null || echo 1)
    DESTDIR="$BUILD_ROOT" ninja -C build install
}

