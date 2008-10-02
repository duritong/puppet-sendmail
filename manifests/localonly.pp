# manifests/localonly.pp
# manages sendmail installations
# which use sendmail only locally
#
# when you set $sendmail_localonly_virtusertable_src
# to a puppet url this file will be used as your virtusertable

class sendmail::localonly inherits sendmail {
    case $sendmail_mailroot {
        '': { fail("you need to define \$sendmail_mailroot on ${fqdn} to use this feature") }
    }

    sendmail::mailalias{'root':
        recipient => $sendmail_mailroot,
    }

    file{"/etc/mail/virtusertable":
        notify => Exec[sendmail_make],
        require => $kernel ? {
           linux => Package[sendmail], 
        },
        mode => 0644, owner => root, group => 0;
    }
    case $sendmail_localonly_virtusertable_src {
        '': {
                File['/etc/mail/virtusertable']{
                    content => template("sendmail/virtusertable/virtusertable.${operatingsystem}"),
                }
            }
        default: {
                File['/etc/mail/virtusertable']{
                    source => $sendmail_localonly_virtusertable_src,
                }
            }
    }
}
