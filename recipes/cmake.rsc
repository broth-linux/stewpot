# Recipe for cmake
NAME="cmake"
VERSION="4.4.2"
DEPENDS=""
URL="https://github.com/Kitware/CMake/archive/refs/tags/v4.4.2.tar.gz"

build() {
    ./bootstrap \
        --prefix=/usr \
        --parallel=$(nproc) \
	--no-system-libs \
	--no-system-jsoncpp \
	--no-system-cppdap \
	--no-system-expat \
	--no-system-librhash

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}
