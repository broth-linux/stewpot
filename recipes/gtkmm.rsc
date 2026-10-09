# Recipe for gtkmm
NAME="gtkmm"
VERSION="3.24.9"
DEPENDS=""
URL="https://download.gnome.org/sources/gtkmm/3.24/gtkmm-3.24.9.tar.xz"
UPSTREAM_SOURCE=""

build() {
    meson setup build \
		--prefix=/usr \
		--buildtype=release \
		-Dbuild-demos=false \
		-Dbuild-documentation=false \
		-Dbuild-tests=false
		
	ninja -C build -j$(nproc)
	DESTDIR="$BUILD_ROOT" ninja -C build install 
}

