# Recipe for gtk+3
NAME="gtk+3"
VERSION="3.24.43"
DEPENDS="gdk-pixbuf cairo pango atk libepoxy libX11 libXext libXrender libXi libXrandr libXcursor libXdamage libXcomposite"
URL="https://download.gnome.org/sources/gtk+/3.24/gtk+-3.24.43.tar.xz"
UPSTREAM_SOURCE=""

build() {

#	sed -i "s/subdir('docs')/# subdir('docs')/" meson.build
#	sed -i "s/subdir('testsuite')/# subdir('testsuite')/" meson.build
#	sed -i "s/subdir('examples')/# subdir('examples')/" meson.build
#
#	sed -i "s/atkbridge_dep = dependency('atk-bridge-2.0'/atkbridge_dep = dependency('atk-bridge-2.0', required: false/" meson.build	
#	sed -i "s/atk_pkgs += \['atk-bridge-2.0'\]/# atk_pkgs += ['atk-bridge-2.0']/" meson.build

#	unset LDFLAGS

	sed -i '24i #pragma GCC diagnostic ignored "-Wunused-function"' gdk/x11/gdkdisplay-x11.c

	sed -i 's/.*throttled_presentation_time.*/(void)0;/' gdk/x11/gdkdisplay-x11.c
	
	meson setup build \
		--prefix=/usr \
		--libdir=/usr/lib \
		--buildtype=release \
		-Dwerror=false \
		-Dc_args="-Wno-error" \
		-Dc_link_args="-Wl,-rpath-link=/usr/lib -lepoxy" \
		-Dx11_backend=true \
		-Dwayland_backend=false \
		-Dbroadway_backend=false \
		-Dintrospection=false \
		-Ddemos=false \
		-Dexamples=false \
		-Dtests=false \
		-Dinstalled_tests=false \
		-Dcolord=no \
		-Dcloudproviders=false \
		-Dtracker3=false \
		-Dman=false \
		--wrap-mode=nofallback

	ninja -C build -j$(nproc)
	DESTIDR="$BUILD_ROOT" ninja -C build install
}



