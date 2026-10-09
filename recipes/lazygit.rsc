# Recipe for lazygit
VERSION="0.44.1"
NAME="lazygit"
DEPENDS="go"
URL="git+https://github.com/jesseduffield/lazygit.git"
UPSTREAM_SOURCE="https://github.com/jesseduffield/lazygit.git"

build() {
	export CGO_ENABLED=0
	go build -ldflags="-s -w -X main.version=${VERSION}" -o bin/lazygit

	mkdir -p "$BUILD_ROOT/usr/bin"
	install -m 755 bin/lazygit "$BUILD_ROOT/usr/bin/lazygit"
}

