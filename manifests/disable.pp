# manifests/disable.pp
# disable sendmail

class sendmail::disable inherits sendmail {
    case $::kernel {
        linux: { include sendmail::disable::base }
    }
    if $sendmail::manage_munin {
        include sendmail::munin::disable
    }
}
