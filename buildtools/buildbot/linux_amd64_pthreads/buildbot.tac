
from twisted.application import service
from buildbot.slave.bot import BuildSlave

basedir = r'/var/lib/buildbot/simgrid/linux_amd64_pthreads'
host = 'bob.loria.fr'
port = 9989
slavename = 'bob'
from slave_account import passwd # Separate file to put this one in the SVN
keepalive = 600
usepty = 1
umask = None

application = service.Application('buildslave')
s = BuildSlave(host, port, slavename, passwd, basedir, keepalive, usepty,
               umask=umask)
s.setServiceParent(application)
