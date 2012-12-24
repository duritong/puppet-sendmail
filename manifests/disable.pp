# disable sendmail
class sendmail::disable inherits sendmail {
  case $::operatingsystem {
    debian: {
      include sendmail::disable::debian
    }
    default: {
      case $::kernel {
        linux: { include sendmail::disable::base }
      }
    }
  }
}
