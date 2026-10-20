# Recipe for libusb
NAME="libusb"
VERSION="1.0.27"
DEPENDS=""
URL="https://github.com/libusb/libusb/releases/download/v1.0.27/libusb-1.0.27.tar.bz2"
UPSTREAM_SOURCE="https://github.com/libusb/libusb.git"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --disable-static \
        --disable-udev \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

