#!/bin/sh

set -x

yum_install() {
    yum --enablerepo=base install -y $@
}

# install dependency packages
yum_install zlib-devel curl curl-devel openssl-devel expat-devel gettext-devel autoconf automake \
            gcc make vim*

# download src
GIT_TARBALL=git-latest.tar.gz
if [ ! -f ${GIT_TARBALL} ]; then
    wget -N http://codemonkey.org.uk/projects/git-snapshots/git/${GIT_TARBALL}
else
    echo "[WARN] ${GIT_TARBALL} is exist..."
fi

# extract it
tar xzvf ${GIT_TARBALL} > /dev/null

GIT_DIR=$(find . -maxdepth 1 -iname 'git-*' -type d)

cd ${GIT_DIR}

# generate config
autoconf

# cofigure it
./configure

make
make install

# test installation result
git --version

# clean up
rm -rf ${GIT_DIR}
rm -f ${GIT_TARBALL}
