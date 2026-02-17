#!/bin/bash
set -e

# Get latest tag and commit count from upstream
REPO_URL="https://github.com/FHIR/sushi.git"

echo "Fetching latest version from $REPO_URL..."
rm -rf upstream.git
# Clone with tags to get the version
git clone --bare --single-branch --branch master "$REPO_URL" upstream.git
cd upstream.git
git fetch --tags
new_pkgver=$(git describe --long --tags | sed 's/^v//;s/\([^-]*-g\)/r\1/;s/-/./g')
cd ..
rm -rf upstream.git

echo "Latest version: $new_pkgver"

# Update PKGBUILD
sed -i "s/^pkgver=.*/pkgver=$new_pkgver/" PKGBUILD

# Update .SRCINFO
# We need makepkg installed for this
if command -v makepkg >/dev/null 2>&1; then
    makepkg --printsrcinfo > .SRCINFO
    echo ".SRCINFO updated"
else
    echo "Warning: makepkg not found, .SRCINFO not updated"
fi
