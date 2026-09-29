# Recipe for Fontconfig
NAME="Fontconfig"
VERSION="2.18.3"
DEPENDS=""
URL="https://gitlab.freedesktop.org/api/v4/projects/890/packages/generic/fontconfig/2.18.3/fontconfig-2.18.3.tar.xz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
	--enable-libxml2 \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

