# Recipe for shared-mime-info
NAME="shared-mime-info"
VERSION="2.1"
DEPENDS=""
URL="https://gitlab.freedesktop.org/xdg/shared-mime-info/-/archive/2.1/shared-mime-info-2.1.tar.gz"
UPSTREAM_SOURCE=""

build() {

	meson setup build \
		--prefix=/usr \
		--buildtype=release \
#	-Dman=false
		
	ninja -C build -j8
	DESTDIR="$BUILD_ROOT" ninja -C build install
}

