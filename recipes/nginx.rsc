# Recipe for nginx
NAME="nginx"
VERSION="1.30.5"
DEPENDS=""
URL="https://nginx.org/download/nginx-1.30.5.tar.gz"
UPSTREAM_SOURCE="https://github.com/nginx/nginx.git"

build() {
	./configure \
		--prefix=/usr \
		--sbin-path=/usr/bin/nginx \
		--conf-path=/etc/nginx/nginx.conf \
		--pid-path=/run/nginx.pid \
		--lock-path=/run/lock/nginx.lock \
		--error-log-path=/var/log/nginx/error.log \
		--http-log-path=/var/log/nginx/access.log \
		--user=nobody \
		--group=nobody \
		--with-http_ssl_module \
		--with-http_v2_module \

	make -j$(nproc 2>/dev/null || echo 1)
	make DESTDIR="$BUILD_ROOT" install
}
