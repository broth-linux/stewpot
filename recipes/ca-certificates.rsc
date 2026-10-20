# Recipe for ca-certificates
NAME="ca-certificates"
VERSION="2.90"
DEPENDS="openssl"
URL="https://curl.se/ca/cacert.pem"
UPSTREAM_SOURCE=""

build() {
	mkdir -p "$BUILD_ROOT/etc/ssl/certs"
	install -m 644 cacert.pem "$BUILD_ROOT/etc/ssl/cert.pem"
	ln -sf cert.pem "$BUILD_ROOT/etc/ssl/certs/ca-certificates.crt"
}
