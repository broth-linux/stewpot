# Recipe for lavat
NAME="lavat"
VERSION="3.0.0"
DEPENDS=""
URL="git+https://github.com/AngelJumbo/lavat.git"
UPSTREAM_SOURCE=""

build() {

    make DESTDIR="$BUILD_ROOT" install
}

