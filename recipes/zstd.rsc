# Recipe for zstd
NAME="zstd"
VERSION="1.5.6"
DEPENDS=""
URL="https://github.com/facebook/zstd/releases/download/v1.5.6/zstd-1.5.6.tar.gz"

build() {
    #./configure \
   #     --prefix=/usr \
  #      --sysconfdir=/etc \
 #       --mandir=/usr/share/man \
#        --localstatedir=/var

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}

