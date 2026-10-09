# Recipe for btop
NAME="btop"
VERSION="1.4.7"
DEPENDS="cmake"
URL="git+https://github.com/aristocratos/btop.git"
UPSTREAM_SOURCE="https://github.com/aristocratos/btop.git"
COMMIT="v1.4.7"

build() {

    cmake -B build \
    	-DCMAKE_INSTALL_PREFIX=/usr \
    	-DCMAKE_BUILD_TYPE=Release \
    	-DBUILD_TESTING=OFF \
    	-DBTOP_LTO=OFF

    cmake --build build -j$(nproc 2>/dev/null || echo 1)
    DESTDIR="$BUILD_ROOT" cmake  --install build
}

