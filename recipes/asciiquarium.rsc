# Recipe for asciiquarium
NAME="asciiquarium"
VERSION="1.1"
DEPENDS="perl"
URL="https://robobunny.com/projects/asciiquarium/asciiquarium.tar.gz"
UPSTREAM_SOURCE=""

build() {
	perl Makefile.PL
	make
	make test
	make install
}

