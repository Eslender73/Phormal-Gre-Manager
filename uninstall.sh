```bash
#!/usr/bin/env bash
set -Eeuo pipefail

INSTALL_FILE="/usr/local/bin/pgm"

if [[ $EUID -ne 0 ]]; then
    echo "Please run as root."
    exit 1
fi

echo "Removing Phormal-Gre-Manager..."

if [[ -f "$INSTALL_FILE" ]]; then
    rm -f "$INSTALL_FILE"
    echo "PGM removed successfully."
else
    echo "PGM is not installed."
fi

echo
echo "Tunnel configurations and services were NOT removed."
```
