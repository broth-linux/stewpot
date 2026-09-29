# Recipe for xorg-server
NAME="xorg-server"
VERSION="21.1.13"
DEPENDS=""
URL="https://www.x.org/pub/individual/xserver/xorg-server-21.1.13.tar.xz"

build() {
    meson setup build \
	--prefix=/usr \
	--buildtype=release \
	-Dsecure-rpc=false \
	-Dudev=false \
	-Dudev_kms=false \
	-Dglx=false \
	-Dglamor=false \
	-Ddri1=false \
	-Ddri2=false \
	-Ddri3=false \
	-Dudev=false \
	-Dsystemd_logind=false \
	-Dxkb_dir=/usr/share/X11/xkb \
	-Dxkb_bin_dir=/usr/bin

    ninja -C build
    ninja -C build install
	

}

