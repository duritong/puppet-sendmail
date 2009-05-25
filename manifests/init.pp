#
# sendmail module
#
# Copyright 2008, Puzzle ITC GmbH
# Marcel Härry haerry+puppet(at)puzzle.ch
# Simon Josi josi+puppet(at)puzzle.ch
#
# This program is free software; you can redistribute 
# it and/or modify it under the terms of the GNU 
# General Public License version 3 as published by 
# the Free Software Foundation.
#

class sendmail {
    case $kernel {
        linux: { include sendmail::base }
    }

    include sendmail::manage

    if $use_munin {
        include sendmail::munin
    }
}

class sendmail::base {
    package{sendmail:
        ensure => present,
    }

    service{sendmail:
        enable => true,
        ensure => running,
        require => Package[sendmail],
    }
}

