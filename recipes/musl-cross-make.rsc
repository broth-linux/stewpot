# Recipe for musl-cross-make
NAME="musl-cross-make"
VERSION="1.0.0"
DEPENDS="gawk perl curl make gcc"
URL="https://github.com/richfelker/musl-cross-make/archive/refs/heads/master.tar.gz"
UPSTREAM_SOURCE=""

build() {
	export LC_ALL=C
	export LANG=C
	export AWK=/usr/bin/gawk

	cat << 'EOF' > config.mak
TARGET = aarch64-linux-musl
OUTPUT = /opt/cross/aarch64-linux-musl
COMMON_CONFIG += --disable-nls
GCC_CONFIG += --enable-languages=c,c++ --disable-libquadmath --disable-decimal-float
MUSL_CONFIG += --enable-optimize=size
DL_CMD = curl -C - -L -o
EOF

	make AWK=/usr/bin/gawk -j$(nproc 2>/dev/null || echo 2)

	make install DESTDIR="$BUILD_ROOT"

	sudo make install
}
