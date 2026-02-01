#!/usr/bin/env bash
set -euo pipefail

# Build a single-file PyInstaller binary and package it into a .deb
# Usage: ./scripts/build_deb.sh [version]

VERSION=${1:-1.0.0}
PKGNAME=coopad
BUILD_DIR=$(pwd)
DIST_DIR=${BUILD_DIR}/dist
PKG_DIR=${BUILD_DIR}/package

echo "Building ${PKGNAME} version ${VERSION}"

# Ensure venv activated or use system python
if [ -z "${VIRTUAL_ENV:-}" ]; then
  echo "Warning: virtualenv not active. It's recommended to activate your venv before building."
fi

echo "Installing build deps (pyinstaller)..."
pip install --upgrade pyinstaller >/dev/null

echo "Running PyInstaller..."
pyinstaller --noconfirm --onefile \
  --name ${PKGNAME} \
  --add-data "img:img" \
  --add-data "gp:gp" \
  main.py

echo "Preparing package tree..."
rm -rf ${PKG_DIR}
mkdir -p ${PKG_DIR}/DEBIAN
mkdir -p ${PKG_DIR}/usr/bin
mkdir -p ${PKG_DIR}/usr/share/doc/${PKGNAME}
mkdir -p ${PKG_DIR}/etc/udev/rules.d

echo "Copying binary and docs..."
cp ${DIST_DIR}/${PKGNAME} ${PKG_DIR}/usr/bin/${PKGNAME}
cp README.md ${PKG_DIR}/usr/share/doc/${PKGNAME}/README.md || true

# Include udev rule so package can install device permissions
cat > ${PKG_DIR}/etc/udev/rules.d/99-coopad-uinput.rules <<'UDEV'
# Allow members of 'input' group to access uinput
KERNEL=="uinput", MODE="0660", GROUP="input"
SUBSYSTEM=="uinput", MODE="0660", GROUP="input"
UDEV

echo "Creating DEBIAN/control..."
cat > ${PKG_DIR}/DEBIAN/control <<EOF
Package: ${PKGNAME}
Version: ${VERSION}
Section: utils
Priority: optional
Architecture: amd64
Depends: python3
Maintainer: CooPad <no-reply@example.com>
Description: CooPad remote gamepad (host/client)
EOF

# Set permissions
chmod -R 0755 ${PKG_DIR}/usr/bin/${PKGNAME} || true
chmod 0644 ${PKG_DIR}/etc/udev/rules.d/99-coopad-uinput.rules

echo "Building .deb package..."
DEBFILE=${BUILD_DIR}/${PKGNAME}_${VERSION}_amd64.deb
dpkg-deb --build ${PKG_DIR} ${DEBFILE}

echo "Package created: ${DEBFILE}"
echo "To install: sudo dpkg -i ${DEBFILE}"
echo "After install, run: sudo udevadm control --reload-rules && sudo udevadm trigger"

exit 0
