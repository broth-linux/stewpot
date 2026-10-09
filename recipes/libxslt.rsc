# Recipe for libxslt
NAME="libxslt"
VERSION="1.1.42"
DEPENDS="libxml2"
URL="https://download.gnome.org/sources/libxslt/1.1/libxslt-1.1.42.tar.xz"
UPSTREAM_SOURCE=""

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
		--without-python
		
    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

