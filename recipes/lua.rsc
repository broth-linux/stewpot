# Recipe for lua
NAME="lua"
VERSION="5.4.7"
DEPENDS="readline"
URL="https://www.lua.org/ftp/lua-5.4.7.tar.gz"
UPSTREAM_SOURCE=""

build() {
	make -j$(nproc 2>/dev/null || echo 1) linux-readline MYLIBS="-lncursesw" MYCFLAGS="-fPIC"
	make INSTALL_TOP="$BUILD_ROOT/usr" install
}
