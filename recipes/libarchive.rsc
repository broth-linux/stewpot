# Recipe for libarchive
NAME="libarchive"
VERSION="3.8.9"
DEPENDS="cmake ninja"
URL="https://libarchive.org/downloads/libarchive-3.8.9.tar.xz"
UPSTREAM_SOURCE=""

build() {
	cmake -B build -G Ninja \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_SYSCONFDIR=/etc \
		-DENABLE_TEST=OFF \
		-DENABLE_TAR=OFF \
		-DENABLE_UNZIP=OFF \
		-DENABLE_CPIO=OFF \
		-DENABLE_OPENSSL=ON \		

	ninja -C build -j$(nproc)
	DESTDIR="$BUILD_ROOT" ninja -C build install
}
