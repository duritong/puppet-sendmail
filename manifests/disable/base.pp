class sendmail::disable::base inherits sendmail::base {
  Package[sendmail]{
    ensure => absent,
    require => Service['sendmail'],
  }

  Service['sendmail']{
    enable => false,
    ensure => stopped,
    require => undef,
  }
}
