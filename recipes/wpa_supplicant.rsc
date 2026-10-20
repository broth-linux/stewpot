# Recipe for wpa_supplicant
NAME="wpa_supplicant"
VERSION="2.12"
DEPENDS="openssl libnl"
URL="https://w1.fi/releases/wpa_supplicant-2.12.tar.gz"
UPSTREAM_SOURCE=""

build() {
	
	cd wpa_supplicant
	

	cat << 'EOF' > .config
CONFIG_DRIVER_NL80211=y
CONFIG_DRIVER_WEXT=y
CONFIG_TLS=openssl
CONFIG_MAIN=main
EOF

	make -j$(nproc)

	install -d -m 755 "$BUILD_ROOT/usr/sbin"
	install -m 755 wpa_supplicant "$BUILD_ROOT/usr/sbin"
	install -m 755 wpa_cli "$BUILD_ROOT/usr/sbin"
	install -m 755 wpa_passphrase "$BUILD_ROOT/usr/sbin"
	
}
