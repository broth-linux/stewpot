NAME="perl"
VERSION="5.38.2"
DEPENDS=""
URL="https://www.cpan.org/src/5.0/perl-5.38.2.tar.xz"

build() {
    ./Configure -des \
        -Dprefix=/usr \
        -Dvendorprefix=/usr \
        -Dusethreads \
        -Duseshrplib \
        -Dman1dir='' \
        -Dman3dir=''
        
    make -j$(nproc)
    make DESTDIR="$BUILD_ROOT" install
}
