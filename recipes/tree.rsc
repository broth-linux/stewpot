# Recipe for tree
NAME="tree"
VERSION="2.1.1"
DEPENDS=""
URL="https://github.com/peteretelej/tree/archive/refs/tags/v1.3.0.tar.gz"
UPSTREAM_SOURCE="https://github.com/peteretelej/tree.git"

build() {
	cargo install \
	--path . \
	--root "$BUILD_ROOT/usr" \
	--locked
}
