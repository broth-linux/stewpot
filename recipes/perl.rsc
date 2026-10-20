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
        -Dman1dir=/tmp/perl-man \
        -Dman3dir=/tmp/perl-man \
        -Dman1ext=1 \
        -Dman3ext=3
        
    make -j$(nproc)
    make DESTDIR="$BUILD_ROOT" install

}

rm -rf /tmp/perl-man
