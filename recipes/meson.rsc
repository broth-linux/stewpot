# Recipe for meson
NAME="meson"
VERSION="1.4.0"
DEPENDS=""
URL="https://files.pythonhosted.org/packages/source/m/meson/meson-1.4.0.tar.gz"


build() {

	[ -f "pyproject.toml" ] || cd meson-* 2>/dev/null || true

	pip3 install --no-deps --no-build-isolation --root="$BUILD_ROOT" --prefix=/usr .

}

#python3 setup.py build
#python3 setup.py install \
#	--prefix=/usr \
#	--root="$BUILD_ROOT"
	
