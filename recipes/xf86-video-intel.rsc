# Recipe for xf86-video-intel
NAME="xf86-video-intel"
VERSION=""
DEPENDS=""
URL="https://gitlab.freedesktop.org/xorg/driver/xf86-video-intel/-/archive/master/xf86-video-intel-master.tar.gz"
UPSTREAM_SOURCE=""

build() {
	CFLAGS="$CFLAGS -Wno-error=incompatible-pointer-types -Wno-error=discarded-qualifiers" \
	meson setup build \
		--prefix=/usr \
		-Dums=false \
		-Dxvmc=false \
		-Duxa=false \
		-Dsna=true \
		-Dvalgrind=false \
		-Ddri1=false \
		-Ddri2=false \
		-Ddri3=false \
		-Dtools=false
		
	ninja -C build
	DESTDIR="$BUILD_ROOT" ninja -C build install
}

