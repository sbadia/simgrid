#! /bin/sh

pipol-sub esn i386_xen-linux-debian-lenny none 00:30 ~/simgrid-svn/buildtools/scripts/make_dist.sh
# i386-linux-debian-testing.dd.gz 
sleep 300

pipol-sub esn i386-linux-ubuntu-intrepid.dd.gz none 00:30 ~/simgrid-svn/buildtools/scripts/test_dist_with_cmake.sh
pipol-sub esn i386-linux-ubuntu-jaunty.dd.gz none 00:30 ~/simgrid-svn/buildtools/scripts/test_dist_with_cmake.sh
pipol-sub esn i386-linux-ubuntu-karmic.dd.gz none 00:30 ~/simgrid-svn/buildtools/scripts/test_dist_with_cmake.sh
pipol-sub esn i386-linux-debian-testing.dd.gz none 00:30 ~/simgrid-svn/buildtools/scripts/test_dist_with_cmake.sh
pipol-sub esn i386-linux-fedora-core11.dd.gz none 00:30 ~/simgrid-svn/buildtools/scripts/test_dist_with_cmake.sh

pipol-sub esn ia64-linux-debian-lenny.dd none 00:30 ~/simgrid-svn/buildtools/scripts/test_dist_with_cmake.sh

pipol-sub esn amd64-linux-ubuntu-intrepid.dd.gz none 00:30 ~/simgrid-svn/buildtools/scripts/test_dist_with_cmake.sh
pipol-sub esn amd64-linux-ubuntu-jaunty.dd.gz none 00:30 ~/simgrid-svn/buildtools/scripts/test_dist_with_cmake.sh
pipol-sub esn amd64-linux-ubuntu-karmic.dd.gz none 00:30 ~/simgrid-svn/buildtools/scripts/test_dist_with_cmake.sh
pipol-sub esn amd64-linux-debian-testing.dd.gz none 00:30 ~/simgrid-svn/buildtools/scripts/test_dist_with_cmake.sh
pipol-sub esn amd64-linux-fedora-core11.dd.gz none 00:30 ~/simgrid-svn/buildtools/scripts/test_dist_with_cmake.sh

pipol-sub esn i386_mac-mac-osx-server-leopard.dd.gz none 00:30 ~/simgrid-svn/buildtools/scripts/test_dist_with_cmake.sh
