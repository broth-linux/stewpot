# Recipe for openssh
NAME="openssh"
VERSION="1.0.0"
DEPENDS=""
URL="https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-9.7p1.tar.gz"

build() {
    ./configure \
        --prefix=/usr \
	--sbindir=/usr/sbin \
        --sysconfdir=/etc/ssh \
	--datadir=/usr/share/openssh \
	--libexecdir=/usr/lib/openssh \
	--without-selinux \
	--without-pam \
	--without-xauth \
	--disable-strip

    make -j$(nproc 2>/dev/null || echo 1)
    make DESTDIR="$BUILD_ROOT" install
}
