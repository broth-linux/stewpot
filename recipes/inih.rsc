# Recipe for inih
NAME="inih"
VERSION="r59"
DEPENDS=""
URL="https://github.com/benhoyt/inih/archive/refs/tags/r59.tar.gz"
UPSTREAM_SOURCE="https://github.com/benhoyt/inih.git"

build() {

	meson setup build \
		--prefix=/usr \
		--buildtype=release
	ninja -C build
	DESTDIR="$BUILD_ROOT" ninja -C build install

}

