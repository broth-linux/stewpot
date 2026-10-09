# Recipe for libsigc++
NAME="libsigc++"
VERSION="2.10.8"
DEPENDS=""
URL="https://download.gnome.org/sources/libsigc++/2.10/libsigc++-2.10.8.tar.xz"
# UPSTREAM_SOURCE="https://github.com/libisigcplusplus/libsigcplusplus.git"

build() {
    meson setup build --prefix=/usr --libdir=/usr/lib --sysconfdir=/etc --buildtype=release 
    ninja -C build -j$(nproc)
    DESTDIR="$BUILD_ROOT" ninja -C build install
}

