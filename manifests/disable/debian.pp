class sendmail::disable::debian inherits sendmail::disable::base {
  Service['sendmail']{
    hasstatus => false,
  }
}
