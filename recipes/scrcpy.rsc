# Recipe for scrcpy
NAME="scrcpy"
VERSION="5.0"
DEPENDS="ffmpeg sdl2 libusb openssl zlib"
URL="https://github.com/Genymobile/scrcpy/archive/refs/tags/v5.0.tar.gz"
UPSTREAM_SOURCE="https://github.com/Genymobile/scrcpy.git"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

