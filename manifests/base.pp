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
