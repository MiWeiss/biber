#!/bin/bash

# Collect all binaries and re-package for CTAN
# re-package.sh <biber version>

declare -r ROOT='/tmp/biber-repack'

mkdir -p ${ROOT}
cd ${ROOT}
declare VER=$1
declare RELEASE="current"
declare PLATFORMS=("linux_x86_64" "MSWIN64" "MSWIN32" "darwinlegacy_x86_64" "darwin_universal")
declare SFPLATFORMS=("Linux" "Windows" "Windows" "MacOS" "MacOS")
declare EXTS=("tar.gz" "zip" "zip" "tar.gz" "tar.gz")

function create-readme {
  cat <<EOF>$2
These are biber binaries for the $1 platform(s).
See https://ctan.org/pkg/biber for documentation, sources, and all else.
EOF
}

# Binaries
for i in "${!PLATFORMS[@]}"; do
    PLATFORM=${PLATFORMS[i]}
    SFPLATFORM=${SFPLATFORMS[i]}
    EXT=${EXTS[i]}
    if [ ! -e biber-$PLATFORM.tgz ]; then
      echo -n "Packaging $PLATFORM ... "
      mkdir biber-$PLATFORM 2>/dev/null
      /opt/local/bin/wget --content-disposition --level=0 -c https://sourceforge.net/projects/biblatex-biber/files/biblatex-biber/$RELEASE/binaries/$SFPLATFORM/biber-$PLATFORM.$EXT -O biber-$PLATFORM/biber-$VER-$PLATFORM.tar.gz >/dev/null 2>&1
      [ $? -eq 0 ] || exit 1
      create-readme $PLATFORM biber-$PLATFORM/README
      tar zcf biber-$PLATFORM.tgz biber-$PLATFORM
      \rm -rf biber-$PLATFORM
      echo "done"
  fi
done

# base
if [ ! -e biber-base.tgz ]; then
  echo -n "Packaging base ... "
  mkdir biber-base 2>/dev/null
  cd biber-base
  /opt/local/bin/wget --content-disposition --level=0 -c https://sourceforge.net/projects/biblatex-biber/files/biblatex-biber/$RELEASE/biblatex-biber.tar.gz -O biblatex-biber.tar.gz >/dev/null 2>&1
  [ $? -eq 0 ] || exit 1
  tar zxf biblatex-biber.tar.gz
  \rm -f biblatex-biber.tar.gz
  /opt/local/bin/wget --content-disposition --level=0 -c https://sourceforge.net/projects/biblatex-biber/files/biblatex-biber/$RELEASE/documentation/biber.pdf -O biblatex-biber-$VER/doc/biber.pdf >/dev/null 2>&1
  [ $? -eq 0 ] || exit 1
  tar zcf biber-$VER-base.tgz biblatex-biber-$VER/*
  \rm -rf biblatex-biber-$VER
  /opt/local/bin/wget --content-disposition --level=0 -c https://sourceforge.net/projects/biblatex-biber/files/biblatex-biber/README.md -O README.md >/dev/null 2>&1
  cd ..
  tar zcf biber-base.tgz biber-base
  \rm -rf biber-base
  echo "done"
fi
