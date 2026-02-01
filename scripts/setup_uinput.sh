#!/usr/bin/env bash
set -euo pipefail

echo "This script installs a udev rule to allow non-root access to uinput devices and adds the current user to the 'input' group."
echo
if ! command -v sudo >/dev/null 2>&1; then
    echo "sudo is required to perform system changes. Install sudo or run as root." >&2
    exit 1
fi

RULE_PATH="/etc/udev/rules.d/99-coopad-uinput.rules"

echo "Writing udev rule to $RULE_PATH (requires sudo)..."
sudo tee "$RULE_PATH" > /dev/null <<'UDEV'
# Allow members of 'input' group to access uinput
KERNEL=="uinput", MODE="0660", GROUP="input"
SUBSYSTEM=="uinput", MODE="0660", GROUP="input"
UDEV

echo "Reloading udev rules..."
sudo udevadm control --reload-rules && sudo udevadm trigger

echo "Adding user '$USER' to group 'input' (requires sudo)..."
sudo usermod -aG input "$USER"

echo
echo "Done. To apply group membership immediately in this shell run:"
echo "  newgrp input"
echo "Or log out and log back in for the change to take effect system-wide."

echo "If you prefer not to change groups, you can run the host as root for testing:"
echo "  sudo -E python3 main.py"

exit 0
