# Recipe for tlrc
NAME="tlrc"
VERSION="1.11.1"
DEPENDS=""
URL="git+https://github.com/tldr-pages/tlrc.git"
UPSTREAM_SOURCE="https://github.com/tldr-pages/tlrc.git"

build() {
    cargo build \
        --release \
        --target x86_64-unknown-linux-musl \
        --locked

    mkdir -p "$BUILD_ROOT/usr/bin"
    strip target/x86_64-unknown-linux-musl/release/tldr
    install -m 755 target/x86_64-unknown-linux-musl/release/tldr "$BUILD_ROOT/usr/bin/tldr"
}

