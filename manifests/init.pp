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

class sendmail(
  $mailroot = hiera('sendmail_mailroot', "root@${::domain}")
) {
  case $::kernel {
    linux: { include sendmail::base }
  }

  include sendmail::manage

  if hiera('use_munin',false) {
    include sendmail::munin
  }
}
