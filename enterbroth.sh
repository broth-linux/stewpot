#!/bin/sh
set -e

TARGET="${1:-./broth-root}"
REPO_URL="https://github.com/broth-linux/stewpot.git"

if [ "$(id -u)" -ne 0 ]; then
	echo "[-] Error: Root privileges required for directory setup and bind mounts." >&2
	exit 1
fi

cleanup() {
	echo "[*] Tearing down mounts..."
	umount -l "$TARGET/dev/pts" 2>/dev/null || true
	umount -l "$TARGET/dev" 2>/dev/null || true
	umount -l "$TARGET/proc" 2>/dev/null || true
	umount -l "$TARGET/sys" 2>/dev/null || true
	umount -l "$TARGET/tmp" 2>/dev/null || true
	umount -l "$TARGET/run" 2>/dev/null || true
}
trap cleanup EXIT INT TERM

echo "[*] Initializing Broth directory structure at $TARGET..."
mkdir -p "$TARGET/bin" \
"$TARGET/sbin" \
"$TARGET/usr/bin" \
"$TARGET/usr/sbin" \
"$TARGET/usr/lib" \
"$TARGET/usr/include" \
"$TARGET/usr/share" \
"$TARGET/etc" \
"$TARGET/dev/pts" \
"$TARGET/proc" \
"$TARGET/sys" \
"$TARGET/tmp" \
"$TARGET/run" \
"$TARGET/var/db/stew/installed" \
"$TARGET/var/cache/stew/sources" \
"$TARGET/root" \
"$TARGET/home"


# Deploy static BusyBox userspace
BUSYBOX_BIN="$TARGET/bin/busybox"
BUSYBOX_URL="https://busybox.net/downloads/binaries/1.35.0-x86_64-linux-musl/busybox"

if [ ! -x "$BUSYBOX_BIN" ]; then
	echo "[*] Fetching static BusyBox binary..."
	if command -v curl >/dev/null 2>&1; then
		curl -fL -o "$BUSYBOX_BIN" "$BUSYBOX_URL"
	elif command -v wget >/dev/null 2>&1; then
		wget -qO "$BUSYBOX_BIN" "$BUSYBOX_URL"
	else
		echo "[-] Error: curl or wget required on host to fetch BusyBox."
		exit 1
	fi
	chmod +x "$BUSYBOX_BIN"
fi

echo "[*] Generating core symlinks from BusyBox..."
(
	cd "$TARGET/bin"
	for applet in $("$BUSYBOX_BIN" --list); do
		ln -sf busybox "$applet"
	done
	ln -sf busybox sh
	ln -sf busybox ash
)


# Explicitly guarentee shell symlinks
ln -sf busybox "$TARGET/bin/sh"
ln -sf busybox "$TARGET/bin/ash"

# Deploy musl dynamic linker and libc
echo "[*] Staging musl libc and dynamic loader..."
mkdir -p "$TARGET/usr/lib"
ln -sf usr/lib "$TARGET/lib"
ln -sf usr/lib "$TARGET/lib64"
ln -sf lib "$TARGET/usr/lib64"
ln -sf /lib/ld-musl-x86_64.so.1 "$TARGET/usr/bin/ldd"

# Copy from host if available
cp -a /lib/ld-musl-x86_64.so.1 "$TARGET/usr/lib/" 2>/dev/null || true
cp -a /usr/lib/libc.so "$TARGET/usr/lib/" 2>/dev/null || true
cp -a /usr/lib/libgcc_s.so* "$TARGET/usr/lib/" 2>/dev/null || true
cp -a /usr/lib/libstdc++.so* "$TARGET/usr/lib/" 2>/dev/null || true

# Stage bootstrap and build binaries
echo "[*] Staging host musl GCC, binutils, make, and C headers..."
mkdir -p "$TARGET/usr/bin" \
	"$TARGET/usr/include" \
	"$TARGET/usr/libexec" \
	"$TARGET/usr/lib/gcc"

# 1. Compiler and build binaries
for bin in gcc cc g++ cpp as ld ar nm ranlib make; do
	if [ -f "/usr/bin/$bin" ]; then
		cp -a "/usr/bin/$bin" "$TARGET/usr/bin/"
	fi
done

# 2. GCC internals (cc1, cc1plus, collect2) and specs/libraries
cp -a /usr/libexec/gcc "$TARGET/usr/libexec/" 2>/dev/null || true
cp -a /usr/lib/gcc "$TARGET/usr/lib/" 2>/dev/null || true
cp -a /usr/lib/gcc/*/*/gcc "$TARGET/usr/bin/gcc" 2>/dev/null || true
ln -sf gcc "$TARGET/usr/bin/cc"

# 3. C standard and kernel headers
cp -a /usr/include/* "$TARGET/usr/include/" 2>/dev/null || true 



# Ensure ld-musl symlink points to libc.so if missing
[ -f "$TARGET/usr/lib/libc.so" ] && [ ! -e "$TARGET/usr/lib/ld-musl-x86_64.so.1" ] && \
	ln -sf libc.so "$TARGET/usr/lib/ld-musl-x86_64.so.1"


# 1. Clone or update the repository inside the target root
SRC_DIR="$TARGET/usr/src/stewpot"
mkdir -p "$TARGET/usr/src"

if [ -d "$SRC_DIR/.git" ]; then
	echo "[*] Repository exists. Pulling latest commits..."
	git -C "$SRC_DIR" pull --ff-only || true
else
	echo "[*] Cloning stewpot into /usr/src/stewpot..."
	git clone "$REPO_URL" "$SRC_DIR"
fi

# 2. Deploy scripts and binaries directly to /usr/bin
echo "[*] Staging Broth tools to /usr/bin..."
TOOLS="stewpot chef dishwash inspector tastetest autodepends checkout pantry prepare editrsc pantry tastetest preparec editrscc resolveheaders seasonings spill stewpot-checksum"

for tool in $TOOLS; do
	found=""
	if [ -f "$SRC_DIR/$tool" ]; then
		found="$SRC_DIR/$tool"
	elif [ -f "$SRC_DIR/bin/$tool" ]; then
		found="$SRC_DIR/bin/$tool"
	fi

	if [ -n "$found" ]; then
		cp -f "$found" "$TARGET/usr/bin/$tool"
		chmod +x "$TARGET/usr/bin/$tool"
	fi
done

# 3. Deploy recipes to the expected recipes path
echo "[*] Setting up recipes directory..."
mkdir -p "$TARGET/usr/bin/recipes"
if [ -d "$SRC_DIR/recipes" ]; then
	cp -rf "$SRC_DIR/recipes/"* "$TARGET/usr/bin/recipes/" 2>/dev/null || true
fi

# 4. Standard POSIX environment and PATH setup
cat << 'EOF' > "$TARGET/etc/profile"
export PATH="/usr/bin:/usr/sbin:/bin:/sbin"
export RECIPES="/usr/bin/recipes"
export HOME="/root"
export TERM="${TERM:-xterm-256color}"
export PS1="broth-chroot [\w]# "
EOF

# Generate minimal passwd and group
if [ ! -f "$TARGET/etc/passwd" ]; then
	echo "[*] Creating standard /etc/passwd and /etc/group..."
	cat << 'EOF ' > "$TARGET/etc/passwd"
root:x:0:0:root:/root:/bin/sh
nobody:x:65534:65534:nobody:/nonexistent:/bin/false
EOF

	cat << 'EOF' > "$TARGET/etc/group"
root:x:0:
wheel:x:10:root
nobody:x:65534:
EOF






# 5. Copy host DNS resolution
if [ -f /etc/resolv.conf ]; then
	cp -L /etc/resolv.conf "$TARGET/etc/resolv.conf" 2>/dev/null || true
fi

# 6. Mount pseudofilesystems
echo "[*] Mounting virtual filesystems..."
mount --bind /dev "$TARGET/dev"
mount --bind /dev/pts "$TARGET/dev/pts" 2>/dev/null || true
mount -t proc proc "$TARGET/proc"
mount -t sysfs sysfs "$TARGET/sys"
mount -t tmpfs tmpfs "$TARGET/tmp"
mount -t tmpfs tmpfs "$TARGET/run"


# Ensure bootstrap compiler toolchain exists in target
if [ ! -x "$TARGET/usr/bin/gcc" ]; then
	echo "[*] Downloading native musl GCC toolchain..."
	curl -fsSL "https://musl.cc/x86_64-linux-musl-native.tgz" -o /tmp/musl-toolchain.tgz
	
	echo "[*] Unpacking toolchain into $TARGET/usr..."
	tar -xvzf /tmp/musl-toolchain.tgz --strip-components=1 -C "$TARGET/usr"

	# Ensure cc and make symlinks exist
	[ ! -e "$TARGET/usr/bin/cc" ] && ln -sf gcc "$TARGET/usr/bin/cc"
	[ ! -e "$TARGET/usr/bin/make" ] && ln -sf /usr/bin/gmake "$TARGET/usr/bin/make" 2>/dev/null || true

	rm -f /tmp/musl-toolchain.tgz
fi


# Bootstrap GNU make if missing from target
if [ ! -x "$TARGET/usr/bin/make" ]; then
	echo "[*] Bootstrapping GNU make into target..."
	chroot "$TARGET" /bin/sh -c '
		export PATH="/usr/bin:/usr/sbin:/bin:/sbin"
		cd /tmp
		MAKE_VER="make-4.4.1"	
		if [ ! -f "make-4.4.1.tar.gz" ]; then
			wget -q "http://ftp.gnu.org/gnu/make/${MAKE_VER}.tar.gz"
		fi
		rm -rf make-4.4.1
		tar -xzvf "${MAKE_VER}.tar.gz"
		cd make-4.4.1

		# Build usign targets compiler and headers
			./configure \
				--prefix=/usr \
				--without-guile \
				--disable-dependency-tracking
		sh ./build.sh
		./make install
		ln -sf make /usr/bin/gmake
		cd /tmp && rm -rf make-4.4.1 "${MAKE_VER}.tar.gz"
	'
fi

# Run base symlinks and auto-installs inside chroot before dropping to shell
echo "[*] Running bootstrap cooking and symlinks..."
chroot "$TARGET" /bin/sh -c '
	export PATH="/usr/bin:/usr/sbin:/bin:/sbin"
	export HOME="/root"

	# 1. Symlinks
	[ ! -e /bin/bash ] && ln -sf /usr/bin/bash /bin/bash 2>/dev/null || true
	[ ! -e /usr/bin/env ] && ln -sf /bin/busybox /usr/bin/env 2>/dev/null || true
	[ ! -e /usr/bin/busybox ] && ln -sf /bin/busybox /usr/bin/busybox 2>/dev/null || true

	# 2. Sequential package builds
	for pkg in sudo zlib perl openssl curl ncurses fzy dialog; do
		if [ ! -d "/var/db/stew/installed/$pkg" ]; then
			echo "[*] Auto-building $pkg..."
			stewpot cook "$pkg"
			stewpot install "pkg"
		fi
	done
'







echo "[+] Entering Broth chroot..."
chroot "$TARGET" /bin/sh -l
		
