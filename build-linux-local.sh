#!/bin/bash
#
# Execute in kernel source directory for easy building.

kernelsrc=$PWD

mkdir -p linux-local-makepkg
cd linux-local-makepkg

# FIXME: this obviously assumes the location of the linux-local files.
cp ~/prog/linux-local/PKGBUILD ./
cp ~/prog/linux-local/linux-local.install ./
cp ~/prog/linux-local/linux-local.preset ./

BUILDDIR=$kernelsrc makepkg -f
