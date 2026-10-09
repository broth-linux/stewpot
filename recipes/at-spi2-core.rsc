# Recipe for at-spi2-core
NAME="at-spi2-core"
VERSION="2.48.3"
DEPENDS="dbus atk libX11 libXtst libXi"
URL="https://download.gnome.org/sources/at-spi2-core/2.48/at-spi2-core-2.48.3.tar.xz"
UPSTREAM_SOURCE=""

build() {

	meson setup build \
		--prefix=/usr \
		--libdir=/usr/lib \
		--buildtype=release \
		-Dintrospection=disabled \
		-Ddocs=false \
		-Dx11=enabled \
		-Dc_link_args="-Wl,-rpath-link=/usr/lib" \
		--wrap-mode=nofallback

	ninja -C build -j$(nproc)
	DESTDIR="$BUILD_ROOT" ninja -C build install
}

