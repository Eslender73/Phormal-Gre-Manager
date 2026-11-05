```bash
#!/usr/bin/env bash
set -Eeuo pipefail

REPO="GITHUB_USERNAME/Phormal-Gre-Manager"
BRANCH="main"
INSTALL_DIR="/usr/local/bin"
INSTALL_FILE="$INSTALL_DIR/pgm"

if [[ $EUID -ne 0 ]]; then
    echo "Please run this installer as root."
    exit 1
fi

echo "========================================"
echo "       Phormal-Gre-Manager Installer"
echo "========================================"

command -v curl >/dev/null 2>&1 || {
    echo "ERROR: curl is required."
    exit 1
}

TMP_FILE="$(mktemp)"
trap 'rm -f "$TMP_FILE"' EXIT

URL="https://raw.githubusercontent.com/$REPO/$BRANCH/pgm"

echo "[1/3] Downloading PGM..."
if ! curl -fLsS "$URL" -o "$TMP_FILE"; then
    echo "ERROR: Download failed."
    exit 1
fi

if [[ ! -s "$TMP_FILE" ]]; then
    echo "ERROR: Downloaded file is empty."
    exit 1
fi

if ! head -n 1 "$TMP_FILE" | grep -qE '^#!/.*(bash|env bash)'; then
    echo "ERROR: Invalid PGM script."
    exit 1
fi

echo "[2/3] Installing..."
install -m 0755 "$TMP_FILE" "$INSTALL_FILE"

echo "[3/3] Checking installation..."
bash -n "$INSTALL_FILE"

echo
echo "========================================"
echo "       Installation completed!"
echo "========================================"
echo
echo "Run the manager using:"
echo
echo "    pgm"
echo
