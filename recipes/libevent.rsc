# Recipe for libevent
NAME="libevent"
VERSION="2.1.13"
DEPENDS=""
URL="https://github.com/libevent/libevent/archive/refs/tags/release-2.1.13-stable.tar.gz"

build() {
cmake -B build -G Ninja \
        -DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
	-DCMAKE_INSTALL_PREFIX=/usr \
	-DCMAKE_DISABLE_BENCHMARK=ON \
	-DCMAKE_DISABLE_TEST=ON \
	-DCMAKE_DISABLE_SAMPLES=ON \
	-DEVENT__LIBRARY_TYPE=BOTH

    ninja -C build -j$(nproc 2>/dev/null || echo 1)
    DESTDIR="$BUILD_ROOT" ninja -C build install 
}
