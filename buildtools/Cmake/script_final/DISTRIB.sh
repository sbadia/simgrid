#!/bin/bash

#GET the OS name
OS=`uname`
node=`uname -n`

# OS specific working directory 
BASEDIR=/pipol
DIR=$BASEDIR/$OS/$node

# Clean any leftover from previous install
echo "remove old directory $BASEDIR/$OS/$node"
rm -rf $BASEDIR/$OS/$node

# create a new directory 
echo "create new directory $BASEDIR/$OS/$node"
mkdir -p $BASEDIR/$OS/$node
cd $BASEDIR/$OS/$node

echo "DISTRIB"

# Install dependencies Linux
echo "get dependencies Linux"
sudo aptitude install -y libtool automake1.10 autoconf libgcj10-dev gcc g++ bash flex flexml doxygen bibtex bibtool iconv bibtex2html addr2line valgrind

# delete the old distrib
rm $BASEDIR/simgrid*.tar.gz

# load the simgrid directory from svn
echo "load simgrid-svn"
svn checkout svn://scm.gforge.inria.fr/svn/simgrid/simgrid/trunk simgrid
cd $BASEDIR/$OS/$node/simgrid

# ./bootstrap
echo "./bootstrap"
./bootstrap

# ./configure
echo "./configure --enable-maintainer-mode --disable-compile-optimizations"
./configure --enable-maintainer-mode --disable-compile-optimizations

# make
echo "make"
make

# make dist
echo "make dist"
make dist

# copy du Cmake sur BASEDIR
cp -r buildtools/ctest/Cmake $BASEDIR/

# copie de la distrib sur BASEDIR
cp simgrid*.tar.gz $BASEDIR/

# suppression des fichiers tmp
cd ..
rm -rf simgrid

echo "Done!"