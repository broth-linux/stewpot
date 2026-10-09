# Recipe for gparted
NAME="gparted"
VERSION="1.8.1"
DEPENDS="parted "
URL="https://downloads.sourceforge.net/gparted/gparted-1.8.1.tar.gz"
UPSTREAM_SOURCE="https://gitlab.gnome.org/GNOME/gparted.git"

build() {
	# Musl C++ fixes: disable polkit/systemd requirements and documentation
	export CXXFLAGS="$CXXFLAGS -D_GNU_SOURCE"
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--disable-doc \
		--disable-scrollkeeper \
		--disable-libparted-dmraid \
		--enable-online-resize \
		--disable-nls

	cat << 'EOF' >> config.h
#ifndef _
#define _(String) (String)
#endif
#ifndef N_
#define N_(String) (String)
#endif
#ifndef ngettext
#define ngettext(Singular, Plural, Number) ((Number == 1) ? (Singular) : (Plural))
#endif
#define bindtextdomain(Package, Directory) ((char *)NULL)
#define bind_textdomain_codeset(Package, Codeset) ((char *)NULL)
#define textdomain(Package) ((char *)NULL)
EOF

		make gpartedbin_LDADD='$(GTKMM_LIBS) -lparted-fs-resize -lparted -lblkid -luuid' -j8
		make DESTDIR="$BUILD_ROOT" install
}

