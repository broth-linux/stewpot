# Recipe for lshw
NAME="lshw"
VERSION="2.20"
DEPENDS=""
URL="git+https://github.com/lyonel/lshw.git"
UPSTREAM_SOURCE="https://github.com/lyonel/lshw.git"

build() {
	
	make static -j$(nproc 2>/dev/null || echo 1) &&
	make gui -j$(nproc 2>/dev/null || echo 1)
	make DESTDIR="$BUILD_ROOT" install-gui
	
}
