# Recipe for feh
NAME="feh"
VERSION="3.13.1"
DEPENDS="imlib2"
URL="https://github.com/derf/feh/archive/refs/tags/3.13.1.tar.gz"
UPSTREAM_SOURCE="https://github.com/derf/feh.git"

build() {
	
	xinerama=0
	curl=0

	flavor_on XINERAMA && xinerama=1
	flavor_on CURL	   && curl=1
	
    make PREFIX=/usr xinerama=$xinerama curl=$curl -j$(nproc 2>/dev/null || echo 1)
    make PREFIX=/usr DESTDIR="$BUILD_ROOT" xinerama=$xinerama curl=$curl install
}

