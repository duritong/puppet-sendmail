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

# modules_dir { "sendmail": }

class sendmail {
    case $kernel {
        linux: { include sendmail::base }
    }

    exec{sendmail_make:
        command => 'cd /etc/mail/ && make',
        refreshonly => true,
        require => Package[sendmail],
    }
    exec{newaliases:
        command => '/usr/bin/newaliases',
        refreshonly => true,
        require => Package[sendmail],
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

