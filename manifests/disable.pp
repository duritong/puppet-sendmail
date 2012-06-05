# manifests/disable.pp
# disable sendmail

class sendmail::disable inherits sendmail {
    case $::kernel {
        linux: { include sendmail::disable::base }
    }
    if hiera('use_munin',false) {
        include sendmail::munin::disable
    }
}
