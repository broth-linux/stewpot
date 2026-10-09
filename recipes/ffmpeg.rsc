# Recipe for ffmpeg
NAME="ffmpeg"
VERSION="9.0.2"
DEPENDS="openssl zlib"
URL="https://github.com/FFmpeg/FFmpeg/archive/refs/tags/n9.0.2.tar.gz"
UPSTREAM_SOURCE="https://github.com/FFmpeg/FFmpeg.git"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

