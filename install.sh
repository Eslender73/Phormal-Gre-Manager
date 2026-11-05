
#!/usr/bin/env bash
set -Eeuo pipefail

REPO="Eslender73/Phormal-Gre-Manager"
BRANCH="main"
INSTALL_DIR="/usr/local/bin"
INSTALL_FILE="$INSTALL_DIR/pgm"

if [[ $EUID -ne 0 ]]; then
    echo "Please run as root."
    exit 1
fi

echo "========================================"
echo "   Phormal-Gre-Manager Installer"
echo "========================================"

command -v curl >/dev/null 2>&1 || {
    echo "Installing curl..."
    apt-get update
    apt-get install -y curl
}

TMP_FILE="$(mktemp)"
trap 'rm -f "$TMP_FILE"' EXIT

URL="https://raw.githubusercontent.com/$REPO/$BRANCH/pgm"

echo "[1/3] Downloading PGM..."

curl -fLsS "$URL" -o "$TMP_FILE" || {
    echo "ERROR: Could not download PGM."
    exit 1
}

if ! head -n 1 "$TMP_FILE" | grep -q '^#!'; then
    echo "ERROR: Invalid PGM file."
    exit 1
fi

echo "[2/3] Checking script syntax..."

bash -n "$TMP_FILE" || {
    echo "ERROR: PGM contains syntax errors."
    exit 1
}

echo "[3/3] Installing..."

install -m 755 "$TMP_FILE" "$INSTALL_FILE"

echo
echo "Installation completed successfully!"
echo "Run the manager using: pgm"
