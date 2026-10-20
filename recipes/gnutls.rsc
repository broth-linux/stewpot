# Recipe for gnutls
NAME="gnutls"
VERSION="3.8.3"
DEPENDS="xz  gmplib nettle"
URL="https://www.gnupg.org/ftp/gcrypt/gnutls/v3.8/gnutls-${VERSION}.tar.xz"
UPSTREAM_SOURCE=""

build() {
	./configure \
		--disable-srp-authentication \
		--disable-psk-authentication \
		--disable-anon-authentication \
		--disable-dhe \
		--disable-ecdhe \
		--disable-openssl-compatibility \
		--disable-dtls-srtp-support \
		--disable-alpn-support \
		--disable-heartbeat-support \
		--disable-libdane \
		--without-p11-kit \
		--with-included-libtasn1 \
		--with-included-unistring \
		--without-tpm \
		--without-zlib
		
	make -j$(nproc 2>/dev/null || echo 1)
	make DESTDIR="$BUILD_ROOT" install
}
