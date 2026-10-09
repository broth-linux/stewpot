# Recipe for perl-xml-parser
NAME="perl-xml-parser"
VERSION="2.47"
DEPENDS="perl libexpat"
URL="https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-2.47.tar.gz"
UPSTREAM_SOURCE="https://github.com/chorny/XML-Parser.git"

build() {
	perl Makefile.PL \
	INSTALLDIRS=vendor \
	EXPATLIBPATH=/usr/lin \
	EXPATINCPATH=/usr/include

	make -j$(nproc)
	make DESTDIR="$BUILD_ROOT" install
}

