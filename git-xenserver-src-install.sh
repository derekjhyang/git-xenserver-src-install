#!/bin/sh

yum_install() {
    yum --enablerepo=base install -y $@
}


yum_install zlib-devel curl curl-devel openssl-devel expat-devel gettext-devel autoconf automake \
            gcc make vim*

# download src
GIT_TARBALL=git-latest.tar.gz
if [ ! -f ${GIT_TARBALL} ]; then
    wget http://codemonkey.org.uk/projects/git-snapshots/git/${GIT_TARBALL}
fi

# extract it
tar xzvf ${GIT_TARBALL}

GIT_DIR=$(find -maxdepth 1 -name 'git-*' -type d)
cd ${GIT_DIR}

# generate config
autoconf

# cofigure it
./configure

make
make install

# test installation result
git --help
