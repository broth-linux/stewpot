#!/bin/sh
# stew-pot: Package manager for Broth Linux

set -e

SCRIPT_REAL=$(readlink -f "$0" 2>/dev/null || realpath "$0" 2>/dev/null || echo "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_REAL")
RECIPES_DIR="${STEW_PATH:-$SCRIPT_DIR/recipes}"

CACHE_DIR="/var/cache/stew/sources"
WORK_DIR="/tmp/stew-pot-workspace"
EXPORT_DIR="/tmp/stew-pot-pkg"
DB_DIR="/var/db/stew/installed"

mkdir -p "$CACHE_DIR" "$WORK_DIR" "$EXPORT_DIR" "$DB_DIR" "$RECIPES_DIR"

if [ "$#" -lt 1 ]; then
    echo "Usage: stew-pot <cook|install|remove|list> [arguments...]"
    exit 1
fi

COMMAND="$1"
shift

download_file() {
    local url="$1"
    local dest="$2"

    if command -v curl >/dev/null 2>&1; then
        curl -fkL --connect-timeout 15 --retry 2 -o "$dest" "$url"
    elif command -v wget >/dev/null 2>&1; then
        wget --no-check-certificate -T 15 -O "$dest" "$url"
    else
        echo "[-] ERROR: Neither curl nor wget found in PATH!"
        return 1
    fi
}

strip_binaries() {
    [ "${NO_STRIP:-0}" = "1" ] && return 0
    command -v strip >/dev/null 2>&1 || return 0

    echo "[*] Stripping symbols to reduce size..."
    if command -v file >/dev/null 2>&1; then
        find "$BUILD_ROOT" -type f -exec file {} + 2>/dev/null | awk -F: '/ELF.*(executable|shared object)/ {print $1}' | while read -r bin; do
            strip --strip-unneeded "$bin" 2>/dev/null || true
        done
    else
        # Busybox fallback: strip all regular files in bin/ and lib/ safely
        find "$BUILD_ROOT/usr/bin" "$BUILD_ROOT/usr/lib" "$BUILD_ROOT/bin" "$BUILD_ROOT/lib" -type f 2>/dev/null | while read -r bin; do
            strip --strip-unneeded "$bin" 2>/dev/null || true
        done
    fi
    find "$BUILD_ROOT" -type f -name "*.a" -exec strip --strip-debug {} + 2>/dev/null || true
}

cook_ingredient() {
    local INGREDIENT="$1"
    local RECIPE="${RECIPES_DIR}/${INGREDIENT}.rsc"

    if [ ! -f "$RECIPE" ]; then
        echo "[-] ERROR: Missing ingredient! No recipe found for '${INGREDIENT}' in $RECIPES_DIR"
        exit 1
    fi

    local DEPS=$(
        NAME="" VERSION="" URL="" DEPENDS=""
        . "$RECIPE"
        echo "$DEPENDS"
    )

    if [ -n "$DEPS" ]; then
        echo "[>] Checking dependencies for ${INGREDIENT}: $DEPS"
        for dep in $DEPS; do
            if [ ! -d "$DB_DIR/$dep" ] && [ ! -d "$EXPORT_DIR/$dep" ]; then
                echo "[>>] Cooking missing dependency: $dep"
                cook_ingredient "$dep"
            else
                echo "[OK] Dependency '$dep' satisfied."
            fi
        done
    fi

    NAME=""
    VERSION=""
    URL=""
    DEPENDS=""
    NO_STRIP=""

    . "$RECIPE"

    if [ -z "$URL" ]; then
        echo "[-] ERROR: Recipe for ${INGREDIENT} has no URL!"
        exit 1
    fi

    echo "[+] Throwing ${INGREDIENT} into the pot..."

    TARBALL=$(basename "$URL")
    if [ ! -f "$CACHE_DIR/$TARBALL" ]; then
        echo "[*] Fetching $URL..."
        download_file "$URL" "$CACHE_DIR/$TARBALL" || {
            echo "[-] ERROR: Failed to download $URL"
            rm -f "$CACHE_DIR/$TARBALL"
            exit 1
        }
    fi

    local BUILD_SUBDIR="$WORK_DIR/src-${NAME}"
    rm -rf "$BUILD_SUBDIR"
    mkdir -p "$BUILD_SUBDIR"

    echo "[*] Extracting $TARBALL..."
    tar -xf "$CACHE_DIR/$TARBALL" -C "$BUILD_SUBDIR"

    # Identify source root safely
    local TOP_DIR_COUNT=$(find "$BUILD_SUBDIR" -mindepth 1 -maxdepth 1 | wc -l)
    if [ "$TOP_DIR_COUNT" -eq 1 ] && [ -d "$(find "$BUILD_SUBDIR" -mindepth 1 -maxdepth 1 -type d)" ]; then
        SRC_DIR=$(find "$BUILD_SUBDIR" -mindepth 1 -maxdepth 1 -type d)
    else
        SRC_DIR="$BUILD_SUBDIR"
    fi

    export BUILD_ROOT="$EXPORT_DIR/$NAME"
    rm -rf "$BUILD_ROOT"
    mkdir -p "$BUILD_ROOT"

    echo "[*] Cooking ${NAME}-${VERSION}..."

    (
        cd "$SRC_DIR"
        set -e
        build
    )
    BUILD_STATUS=$?

    if [ $BUILD_STATUS -eq 0 ]; then
        strip_binaries
        echo "[+] Successfully cooked ${INGREDIENT}!"
    else
        echo "[-] BURNED THE DINNER! Build failed for ${INGREDIENT}."
        rm -rf "$BUILD_ROOT"
        exit 1
    fi

    rm -rf "$BUILD_SUBDIR"
}

case "$COMMAND" in
    cook)
        [ "$#" -lt 1 ] && { echo "Usage: stew-pot cook <pkg1> [pkg2 ...]"; exit 1; }
        for ing in "$@"; do
            cook_ingredient "$ing"
        done
        echo "[+] All ingredients cooked! Staged in $EXPORT_DIR"
        ;;

    install)
        [ "$#" -lt 1 ] && { echo "Usage: stew-pot install <pkg1> [pkg2 ...]"; exit 1; }
        [ "$(id -u)" -ne 0 ] && { echo "[-] ERROR: Root privileges required."; exit 1; }

        for INGREDIENT in "$@"; do
            PKG_DIR="$EXPORT_DIR/$INGREDIENT"
            RECIPE="${RECIPES_DIR}/${INGREDIENT}.rsc"

            if [ ! -d "$PKG_DIR" ]; then
                echo "[-] ERROR: '${INGREDIENT}' not cooked yet! Run 'stew-pot cook ${INGREDIENT}' first."
                exit 1
            fi

            echo "[*] Installing ${INGREDIENT} to /..."
            PKG_DB="$DB_DIR/$INGREDIENT"
            mkdir -p "$PKG_DB"

            ( cd "$PKG_DIR" && find . ! -type d | sed 's|^\.||' ) > "$PKG_DB/manifest"

            if [ -f "$RECIPE" ]; then
                NAME=""
                VERSION=""
                DEPENDS=""
                . "$RECIPE"
                echo "$VERSION" > "$PKG_DB/version"
                [ -n "$DEPENDS" ] && echo "$DEPENDS" > "$PKG_DB/depends"
            fi

            cp -a "$PKG_DIR/" /
            echo "[+] Successfully installed ${INGREDIENT}!"
        done
        ;;

    remove)
        [ "$#" -lt 1 ] && { echo "Usage: stew-pot remove <pkg1> [pkg2 ...]"; exit 1; }
        [ "$(id -u)" -ne 0 ] && { echo "[-] ERROR: Root privileges required."; exit 1; }

        for INGREDIENT in "$@"; do
            PKG_DB="$DB_DIR/$INGREDIENT"
            MANIFEST="$PKG_DB/manifest"

            if [ ! -f "$MANIFEST" ]; then
                echo "[-] ERROR: No manifest found for '${INGREDIENT}'."
                exit 1
            fi

            echo "[*] Removing ${INGREDIENT}..."
            while IFS= read -r file; do
                if [ -f "$file" ] || [ -L "$file" ]; then
                    rm -f "$file"
                    rmdir -p "$(dirname "$file")" 2>/dev/null || true
                fi
            done < "$MANIFEST"

            rm -rf "$PKG_DB"
            echo "[+] Successfully removed ${INGREDIENT}!"
        done
        ;;

    list)
        echo "=== Installed Stew Packages ==="
        if [ ! -d "$DB_DIR" ] || [ -z "$(ls -A "$DB_DIR" 2>/dev/null)" ]; then
            echo "No packages currently installed."
        else
            for pkg in "$DB_DIR"/*; do
                [ -d "$pkg" ] || continue
                pname=$(basename "$pkg")
                pver=$(cat "$pkg/version" 2>/dev/null || echo "unknown")
                printf "  * %-20s %s\n" "$pname" "$pver"
            done
        fi
        ;;

    *)
        echo "[-] Unknown command: $COMMAND"
        echo "Valid commands: cook, install, remove, list"
        exit 1
        ;;
esac
