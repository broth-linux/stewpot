# Recipe for tint2
NAME="tint2"
VERSION="17.0.2"
DEPENDS="libXinerama"
URL="git+https://gitlab.com/o9000/tint2.git"
UPSTREAM_SOURCE="https://gitlab.com/o9000/tint2.git"

build() {
	cmake -B build -G Ninja \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_SYSCONFDIR=/etc \
		-DENABLE_RSVG=OFF \
		-DCMAKE_INSTALL_LOCALSTATEDIR=var \
		-DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
		-DENABLE_SN=OFF \
		-DENABLE_TINT2CONF=OFF

	ninja -C build -j$(nproc 2>/dev/null || echo 1)
	DESTDIR="$BUILD_ROOT" ninja -C build install
}
