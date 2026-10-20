# Recipe for ffmpeg
NAME="ffmpeg"
VERSION="7.1"
DEPENDS="openssl zlib"
URL="https://ffmpeg.org/releases/ffmpeg-${VERSION}.tar.xz"
UPSTREAM_SOURCE="https://github.com/FFmpeg/FFmpeg.git"

build() {
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--enable-shared \
		--disable-static \
		--enable-gpl \
		--enable-version3 \
		--enable-openssl \
		--enable-zlib \
		--disable-debug 

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

