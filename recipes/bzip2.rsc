# Recipe for bzip2
NAME="bzip2"
VERSION="1.0.8"
DEPENDS=""
URL="https://sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz"
UPSTREAM_SOURCE=""

build() {

    make -f Makefile-libbz2_so
   
}

