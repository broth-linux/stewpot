# Recipe for go
NAME="go"
VERSION="1.22.0"
DEPENDS=""
URL="https://go.dev/dl/go1.22.0.src.tar.gz"
UPSTREAM_SOURCE="https://go.dev"

build() {
	export GOROOT_BOOTSTRAP="$(go env GOROOT)"
	cd src
	./make.bash

	cd ../
	mkdir -p "$BUILD_ROOT/usr/lib/go" "$BUILD_ROOT/usr/bin"
	cp -a bin pkg src lib "$BUILD_ROOT/usr/lib/go/"
	ln -sf /usr/lib/go/bin/go "$BUILD_ROOT/usr/bin/go"
	ln -sf /usr/lib/go/bin/gofmt "$BUILD_ROOT/usr/bin/gofmt"
}

