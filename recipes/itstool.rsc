# Recipe for itstool
NAME="itstool"
VERSION="2.0.6"
DEPENDS=""
URL="https://files.itstool.org/itstool/itstool-2.0.6.tar.bz2"
UPSTREAM_SOURCE=""

build() {

	PYTHON=/usr/bin/python3
	./configure \
		--prefix=/usr\
	make 
	make DESTDIR="$BUILD_ROOT" install


}

