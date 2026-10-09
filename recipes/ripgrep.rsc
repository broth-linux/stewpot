# Recipe for ripgrep
NAME="ripgrep"
VERSION="14.1.1"
DEPENDS=""
URL="git+https://github.com/BurntSushi/ripgrep.git"
UPSTREAM_SOURCE="https://github.com/BurntSushi/ripgrep.git"

build() {
    cargo build \
    	--release \
    	--target x86_64-unknown-linux-musl \
    	--locked

    mkdir -p "$BUILD_ROOT/usr/bin"
    strip target/x86_64-unknown-linux-musl/release/rg
    install -m 755 target/x86_64-unknown-linux-musl/release/rg "$BUILD_ROOT/usr/bin/rg"
}

