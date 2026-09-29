# Recipe for pixman
NAME="pixman"
VERSION="0.46.4"
DEPENDS=""
URL="https://www.cairographics.org/releases/pixman-0.46.4.tar.gz"

meson setup build \
        --prefix=/usr \
        --buildtype=release \
        --Dgtk=disabled
    ninja -C build
    DESTDIR="$BUILD_ROOT" ninja -C build install


