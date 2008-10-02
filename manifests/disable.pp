# manifests/disable.pp
# disable sendmail

class sendmail::disable inherits sendmail::base {
    Package[sendmail]{
        ensure => absent,
    }

    Service[sendmail]{
        enable => false,
        ensure => stopped,
    }

    if $use_munin {
        include sendmail::munin::disable
    }
}
