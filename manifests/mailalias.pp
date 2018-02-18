# manage a mailalias more conveniently.
define sendmail::mailalias(
  Enum['present','absent'] $ensure    = 'present',
  Optional[String]         $recipient = undef,
  String                   $target    = 'absent',
){
  if $ensure == 'present' and !$recipient {
    fail('Must pass recipient if ensure is present')
  }
  include ::sendmail::newaliases

  case $target {
    'absent': {
      $real_target = $facts['operatingsystem'] ? {
        'OpenBSD' => '/etc/mail/aliases',
        default   => '/etc/aliases',
      }
    }
    default: { $real_target = $target }
  }

  mailalias{$name:
    ensure => $ensure,
    target => $real_target,
    notify => Exec['refresh_aliases'],
  }
  if $ensure == 'present' {
    Mailalias[$name]{
      recipient => $recipient,
    }
  }
}
