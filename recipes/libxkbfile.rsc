# Recipe for libxkbfile
NAME="libxkbfile"
VERSION="1.2.0"
DEPENDS=""
URL="https://www.x.org/releases//individual/lib/libxkbfile-1.2.0.tar.xz"

build() {
	meson setup build \
		--prefix=/usr \
		--buildtype=release

	ninja -C build
	ninja -C build install
}

