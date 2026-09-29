# Recipe for fastfetch
NAME="fastfetch"
VERSION="2.34.0"
DEPENDS=""
URL="https://example.com/source/fastfetch-2.34.0.tar.gz"
UPSTREAM_SOURCE=""

build() {
	cmake -B build -S . \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DIS_MUSL=ON \
		-DENABLE_X11=ON \
		-DENABLE_IMAGEMAGICK6=OFF \
		-DENABLE_IMAGEMAGICK7=OFF \
		-DENABLE_LUA=OFF \
		-DENABLE_QUICKJS=OFF \
		-DENABLE_LIBZFS=OFF \
		-DENABLE_WIN81_COMPAT=OFF \
		-DENABLE_APPLE_MEMSIZE_USABLE=OFF \
		-DENABLE_CHAFA=OFF \
		-DENABLE_SIXEL=OFF 

	cmake --build build -j$(nproc)
	DESTDIR="$BUILD_ROOT" cmake --install build 

}

