NAME="perl"
VERSION="5.38.2"
DEPENDS=""
URL="https://www.cpan.org/src/5.0/perl-5.38.2.tar.xz"

build() {
    ./Configure -des \
        -Dprefix=/usr \
        -Dvendorprefix=/usr \
        -Duseithreads \
        -Dman1dir=none \
        -Dman3dir=none

    make -j$(nproc)
    make install
}