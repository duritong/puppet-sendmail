# manifests/localonly.pp
# manages sendmail installations
# which use sendmail only locally
#
# when you set $sendmail_localonly_virtusertable_src
# to a puppet url this file will be used as your virtusertable

class sendmail::localonly(
  $manage_shorewall = false,
  $ocalonly_virtusertable_src = ''
) {

  class{'sendmail':
    manage_shorewall => $manage_shorewall
  }
  sendmail::mailalias{'root':
    recipient => sendmail::mailroot,
  }

  file{"/etc/mail/virtusertable":
    notify => Exec[sendmail_make],
    require => $::kernel ? {
      linux => Package[sendmail],
      default => undef,
    },
    mode => 0644, owner => root, group => 0;
  }
  case $localonly_virtusertable_src {
    '': {
      File['/etc/mail/virtusertable']{
        content => template("sendmail/virtusertable/virtusertable.${::operatingsystem}")
      }
    }
    default: {
      File['/etc/mail/virtusertable']{
        source => $localonly_virtusertable_src,
      }
    }
  }
}
