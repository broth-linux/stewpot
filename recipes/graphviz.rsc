# Recipe for graphviz
NAME="graphviz"
VERSION="16.1.0"
DEPENDS=""
URL="https://gitlab.com/graphviz/graphviz/-/archive/16.1.0/graphviz-16.1.0.tar.gz"
UPSTREAM_SOURCE=""	

build() {
	cmake -B build -G Ninja \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_SYSCONFDIR=/etc \
		-DCMAKE_INSTALL_LOCALSTATEDI=/var

		ninja -C build -j$(nproc 2>/dev/null || echo 1)
		DESTDIR="$BUILD_ROOT" ninja -C build install
}

