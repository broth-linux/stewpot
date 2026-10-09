# Recipe for libsdl2
NAME="libsdl2"
VERSION="3.4.18"
DEPENDS=""
URL="https://github.com/libsdl-org/SDL/archive/refs/tags/release-3.4.18.tar.gz"
UPSTREAM_SOURCE="https://github.com/libsdl-org/SDL.git"

build() {
    cmake -B build -G Ninja \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_C_FLAGS="-I/usr/include" \
        -DCMAKE_BUILD_TYPE=Release \
        -DSDL_X11=ON \
        -DSDL_X11_SHARED=OFF \
        -DSDL_TESTS=OFF \
        -DSDL_PULSEADUDIO=OFF \
        -DSDL_WAYLAND=OFF \
        -DSDL_VULKAN=OFF \
        -DSDL_ALSA=OFF \
        -DSDL_X11_XSCRNSAVER=OFF \
        -DSDL_X11_XFIXES=OFF \
        -DSDL_X11_XCURSOR=OFF
    ninja -C build -j$(nproc 2>/dev/null || echo 1)
    DESTDIR="$BUILD_ROOT" ninja -C build install
}

