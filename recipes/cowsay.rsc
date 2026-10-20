# Recipe for cowsay
NAME="cowsay"
VERSION="1.0.0"
DEPENDS=""
URL="git+https://github.com/0xAether/ccowsay.git"
UPSTREAM_SOURCE="https://github.com/0xAether/ccowsay.git"

build() {
	${CC:-gcc} -O2 -Wall cowsay.c -o cowsay

	install -d "$BUILD_ROOT/usr/bin"
	install -m 755 cowsay "$BUILD_ROOT/usr/bin/cowsay"
}
