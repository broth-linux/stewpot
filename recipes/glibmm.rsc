# Recipe for glibmm
NAME="glibmm"
VERSION="2.66.8"
DEPENDS="glib libsigc++ doxygen libxslt" 
URL="https://download.gnome.org/sources/glibmm/2.66/glibmm-2.66.8.tar.xz"
# UPSTREAM_SOURCE="https://gitlab.com/GNOME/glibmm.git"

build() {
	find build -type f -name "emblem.h" -exec sed -i 's/struct _GEmblemClass/struct GEmblemClass/g' {} +
	find build -type f -name "dbusactiongroup.h" -exec sed -i 's/struct _GDBusActionGroupClass/struct GDBusActionGroupClass/g' {} +
	
	meson setup build --prefix=/usr --libdir=/usr/lib --sysconfdir=/etc --buildtype=release -Dmaintainer-mode=true -Dbuild-documentation=false
	ninja -C build -j$(nproc)
	DESTDIR="$BUILD_ROOT" ninja -C build install
}

