NAME="pkgconf"
VERSION="2.2.0"
DEPENDS=""
URL="https://distfiles.ariadne.space/pkgconf/pkgconf-2.2.0.tar.xz"

build() {
    ./configure \
        --prefix=/usr \
        --bindir=/usr/bin \
        --libdir=/usr/lib \
        --disable-static \
        --with-pkg-config-dir=/usr/lib/pkgconfig:/usr/share/pkgconfig

    make -j$(nproc)
    make install

    # Symlink to standard pkg-config names
    ln -sf pkgconf /usr/bin/pkg-config
}