# Recipe for meson
NAME="meson"
VERSION="1.12.1"
DEPENDS=""
URL="https://github.com/mesonbuild/meson/releases/download/1.12.1/meson-1.12.1.tar.gz"


cd meson-1.12.1
pip3 install --no-deps --no-build-isolation --prefix=/usr --root="$BUILD_ROOT" .

#python3 setup.py build
#python3 setup.py install \
#	--prefix=/usr \
#	--root="$BUILD_ROOT"
	
