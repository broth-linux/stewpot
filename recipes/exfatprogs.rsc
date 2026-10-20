# Recipe for exfatprogs
NAME="exfatprogs"
VERSION="1.2.5"
DEPENDS=""
URL="git+https://github.com/exfatprogs/exfatprogs.git"
UPSTREAM_SOURCE=""

build() {
	./autogen.sh --no-configure
	./configure \
		--prefix=/usr \
		--sbindir=/sbin \
		--disable-static
		
	
    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

