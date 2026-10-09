# Recipe for libexpat
NAME="libexpat"
VERSION="2.8.5"
DEPENDS=""
URL="https://github.com/libexpat/libexpat/archive/refs/tags/R_2_8_5.tar.gz"
UPSTREAM_SOURCE="https://github.com/libexpat/libexpat.git"




build() {
	cd /tmp/stew-pot-workspace/src-libexpat/libexpat-*/expat || exit 1
	
    cmake -B build -G Ninja\
    	-DCMAKE_INSTALL_PREFIX=/usr \
    	-DCMAKE_BUILD_TYPE=Release \
    	-DCMAKE_INSTALL_LIBDIR=lib \
    	-DBUILD_SHARED_LIBS=ON \
    	-DEXPAT_BUILD_DOCS=OFF \
    	-DEXPAT_BUILD_EXAMPLES=OFF \
		-DEXPAT_BUILD_TESTS=OFF    	

    ninja -C build -j8
    DESTDIR="$BUILD_ROOT" ninja -C build install
}

