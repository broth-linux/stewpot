# Recipe for toipe
NAME="toipe"
VERSION="0.4.0"
DEPENDS=""
URL="https://github.com/Samyak2/toipe/archive/refs/tags/v0.4.0.tar.gz"
UPSTREAM_SOURCE="https://github.com/Samyak2/toipe.git"

build() {
	cargo install \
		--path . \
		--root "$BUILD_ROOT/usr" \
		--locked
}
