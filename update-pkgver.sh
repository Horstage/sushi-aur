#!/bin/bash

# For debugging set TRACE=1
if [[ ${TRACE-0} == "1" ]]; then
  set -o xtrace
fi

# Print help text
if [[ ${1-} =~ ^-*h(elp)?$ ]]; then
  echo 'Usage: ./update-pkgver.sh

Updates pkgver in PKGBUILD and .SRCINFO from upstream.

Options:
  -h, --help    Show this help text'
  exit
fi

# Setup
## Exit, when a command fails
set -o errexit
## Exit, when a variable is not set
set -o nounset
## Exit, when command in pipeline fails
set -o pipefail

# Change to the script's directory
cd "$(dirname "$0")"

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
