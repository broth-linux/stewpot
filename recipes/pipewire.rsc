# Recipe for pipewire
NAME="pipewire"
VERSION="1.6.9"
DEPENDS=""
URL="https://gitlab.freedesktop.org/pipewire/pipewire/-/archive/1.6.9/pipewire-1.6.9.tar.bz2"
UPSTREAM_SOURCE=""
	
	export LDFLAGS="$LDFLAGS -lncurses"

build() {
	meson setup build \
		--prefix=/usr \
		--buildtype=release \
		--sysconfdir=/etc \
		--wrap-mode=nodownload \
		-Dtests=disabled \
		-Ddocs=disabled \
		-Dreadline=disabled \
		-Dvulkan=disabled \
		-Dman=disabled \
		-Dgstreamer=disabled \
		-Dsession-managers=[] \
		-Dalsa=disabled \
		-Dspa-plugins=enabled \
		-Draop=disabled \
		-Dexamples=disabled \
		-Dlibcamera=disabled \
		-Dsystemd-system-service=disabled \
		-Dsystemd-user-service=disabled

	ninja -C build -j$(nproc 2>/dev/null || echo 1)
	DESTDIR="$BUILD_ROOT" ninja -C build install
}
