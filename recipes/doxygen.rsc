# Recipe for doxygen
NAME="doxygen"
VERSION="1.12.0"
DEPENDS="cmake python"
URL="https://github.com/doxygen/doxygen/archive/refs/tags/Release_1_12_0.tar.gz"
UPSTREAM_SOURCE="https://github.com/doxygen/doxygen.git"

build() {
    	cmake -B build -G Ninja \
			-DCMAKE_INSTALL_PREFIX=/usr \
    		-DCMAKE_BUILD_TYPE=Release \
    		-DCMAKE_INSTALL_SYSCONFDIR=/etc \
    		-DCMAKE_INSTALL_LOCALSTATEDIR=/var
    		
	ninja -C build -j$(nproc)
	DESTDIR="$BUILD_ROOT" ninja -C build install
}

