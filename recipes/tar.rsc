# Recipe for tar
NAME="tar"
VERSION="9.2"
DEPENDS=""
URL="https://ftp.gnu.org/gnu/tar/tar-1.35.tar.xz"

build() {
FORCE_UNSAFE_CONFIGURE=1 ./configure \
        --prefix=/usr \
 	--bindir=/usr/bin \
	--disable-nls

    make -j$(nproc)
    make install
}
