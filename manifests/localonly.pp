# manifests/localonly.pp
# manages sendmail installations
# which use sendmail only locally
#
# when you set $sendmail_localonly_virtusertable_src
# to a puppet url this file will be used as your virtusertable
class sendmail::localonly(
  $manage_shorewall            = false,
  $localonly_virtusertable_src = false,
) {
  class{'::sendmail':
    manage_shorewall => $manage_shorewall
  }
  sendmail::mailalias{'root':
    recipient => $sendmail::mailroot,
  }

  file{'/etc/mail/virtusertable':
    notify => Exec[sendmail_make],
    owner => root,
    group => 0,
    mode  => '0644';
  }
  if $::kernel == 'Linux' {
    File['/etc/mail/virtusertable']{
      require => Package['sendmail'],
    }
  }
  if $localonly_virtusertable_src {
    File['/etc/mail/virtusertable']{
      source => $localonly_virtusertable_src,
    }
  } else {
    File['/etc/mail/virtusertable']{
      content => template("sendmail/virtusertable/virtusertable.${::operatingsystem}")
    }
  }
}
