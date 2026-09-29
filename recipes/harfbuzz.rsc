# Recipe for harfbuzz
NAME="harfbuzz"
VERSION="14.5.0"
DEPENDS=""
URL="https://github.com/harfbuzz/harfbuzz/archive/refs/tags/14.5.0.tar.gz"
UPSTREAM_SOURCE="https://github.com/harfbuzz/harfbuzz.git"

build() {
	meson setup build \
        --prefix=/usr \
		--buildtype=release \
		--wrap-mode=nofallback \
		--default-library=both 
	ninja -C build
	DESTDIR="$BUILD_ROOT" ninja -C build install

}

