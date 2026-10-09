# Recipe for git
NAME="git"
VERSION="2.44.0"
DEPENDS="curl openssl zlib"
URL="https://mirrors.edge.kernel.org/pub/software/scm/$NAME/$NAME-$VERSION.tar.xz"

build() {
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --localstatedir=/var

    make \
	NO_TCLTK=1 \
	NO_GETTEXT=1 \
	NO_PYTHON=1 \
	NO_PERL=1 \
	NO_EXPAT=1 \
	-j$(nproc 2>/dev/null || echo 1)

    make \
	NO_TCLTK=1 \
	NO_GETTEXT=1 \
	NO_PYTHON=1 \
	NO_PERL=1 \
	NO_EXPAT=1 \
	DESTDIR="$BUILD_ROOT" \
 	install
}
