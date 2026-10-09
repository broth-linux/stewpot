# Recipe for pangomm
NAME="pangomm"
VERSION="2.46.4"
DEPENDS="pango cairomm glibmm"
URL="https://github.com/GNOME/pangomm/archive/refs/tags/2.46.4.tar.gz"
UPSTREAM_SOURCE=""

build() {
	meson setup build \
		--prefix=/usr \
		--sysconfdir=/etc \
		--buildtype=release 
		
	ninja -C build -j$(nproc)
	DESTDIR="$BUILD_ROOT" ninja -C build install

}

