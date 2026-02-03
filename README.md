# fsh-sushi-git AUR package

This repository contains the `PKGBUILD` for the `fsh-sushi-git` package, which provides [SUSHI](https://github.com/FHIR/sushi), a FHIR Shorthand (FSH) compiler.

## Installation

You can install this package from the AUR using an AUR helper:

```bash
yay -S fsh-sushi-git
```

Or manually:

```bash
git clone https://aur.archlinux.org/fsh-sushi-git.git
cd fsh-sushi-git
makepkg -si
```

## Automatic Updates

The version in this repository is automatically updated daily via GitHub Actions.

## Package Name Conflict

Note that this package conflicts with the official `sushi` package (GNOME Sushi). Both provide a `/usr/bin/sushi` binary. This package also provides `/usr/bin/fsh-sushi` for clarity.
