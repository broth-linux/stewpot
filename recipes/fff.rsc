# Recipe for fff
NAME="fff"
VERSION="2.2"
DEPENDS=""
URL="https://github.com/dylanaraps/fff/archive/refs/tags/2.2.tar.gz"
UPSTREAM_SOURCE="https://github.com/dylanaraps/fff.git"

build() {

    make DESTDIR="$BUILD_ROOT" install
    
}

