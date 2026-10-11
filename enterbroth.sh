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
mkdir -p "$TARGET/sbin" \
mkdir -p "$TARGET/usr/bin" \
mkdir -p "$TARGET/usr/sbin" \
mkdir -p "$TARGET/usr/lib" \
mkdir -p "$TARGET/usr/include" \
mkdir -p "$TARGET/usr/share" \
mkdir -p "$TARGET/etc" \
mkdir -p "$TARGET/dev/pts" \
mkdir -p "$TARGET/proc" \
mkdir -p "$TARGET/sys" \
mkdir -p "$TARGET/tmp" \
mkdir -p "$TARGET/run" \
mkdir -p "$TARGET/var/db/stew/installed" \
mkdir -p "$TARGET/var/cache/stew/sources" \
mkdir -p "$TARGET/root" \
mkdir -p "$TARGET/home"


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
# Install base applet symlinks directly into $TARGET/bin
"$BUSYBOX_BIN" --install -s "$TARGET/bin"

# Explicitly guarentee shell symlinks
ln -sf busybox "$TARGET/bin/sh"
ln -sf busybox "$TARGET/bin/ash"

# Deploy musl dynamic linker and libc
echo "[*] Staging musl libc and dynamic loader..."
mkdir -p "$TARGET/usr/lib"
ln -sf usr/lib "$TARGET/lib"

# Copy from host if available
cp -a /lib/ld-musl-x86_64.so.1 "$TARGET/usr/lib/" 2>/dev/null || true
cp -a /usr/lib/libc.so "$TARGET/usr/lib/" 2>/dev/null || true
cp -a /usr/lib/libgcc_s.so* "$TARGET/usr/lib/" 2>/dev/null || true
cp -a /usr/lib/libstdc++.so* "$TARGET/usr/lib/" 2>/dev/null || true


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
TOOLS="stewpot chef diswash inspector tastetest autodepends checkout pantry prepare editrsc pantry tastetest preaprec editrscc resolveheaders seasonings spill stewpot-checksum"

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

# 5. Copy host DNS resolution
if [ -f /etc/resolv.conf ]; then
	cp -L /etc/resolv.conf "$TARGET/etc/resolve.conf" 2>/dev/null || true
fi

# 6. Mount pseudofilesystems
echo "[*] Mounting virtual filesystems..."
mount --bind /dev "$TARGET/dev"
mount --bind /dev/pts "$TARGET/dev/pts" 2>/dev/null || true
mount -t proc proc "$TARGET/proc"
mount -t sysfs sysfs "$TARGET/sys"
mount -t tmpfs tmpfs "$TARGET/tmp"
mount -t tmpfs tmpfs "$TARGET/run"

echo "[+] Entering Broth chroot..."
chroot "$TARGET" /bin/sh -l
		
