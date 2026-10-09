NAME="argp-standalone"
VERSION="1.4.1"
DEPENDS=""
URL="https://sources.voidlinux.org/argp-standalone-1.4.1/1.4.1.tar.gz"

build() {
	SRC_DIR="/var/cache/stew/sources"
	if [ -f "$SRC_DIR/1.4.1.tar.gz" ]; then
		mv "$SRC_DIR/1.4.1.tar.gz" "$SRC_DIR/${NAME}-${VERSION}.tar.gz"
	fi


	gcc -O2 -fPIC -I. -c argp-ba.c argp-eexst.c argp-fmtstream.c argp-help.c argp-parse.c argp-pv.c argp-pvh.c

	ar rcs libargp.a argp-*.o


    mkdir -p "$BUILD_ROOT/usr/include" "$BUILD_ROOT/usr/lib"
    cp -v argp.h "$BUILD_ROOT/usr/include/"
    cp -v libargp.a "$BUILD_ROOT/usr/lib/"
}
