# manifests/localonly.pp
# manages sendmail installations
# which use sendmail only localy

class sendmail::localonly inherits sendmail {
    file{"/etc/aliases":
        source => [ "puppet://$server/files/sendmail/aliases/aliases.${operatingsystem}",
                    "puppet://$server/files/sendmail/aliases/aliases",
                    "puppet://$server/sendmail/aliases/aliases.${operatingsystem}",
                    "puppet://$server/sendmail/aliases/aliases" ],
        require => Package[sendmail],
        notify => Exec[newaliases],
        mode => 0644, owner => root, group => 0;
    }

    $real_sendmail_mailroot = $sendmail_mailroot ? {
        '' => 'monitor@ww2.ch',
        default => $sendmail_mailroot
    }

    file{"/etc/mail/virtusertable":
        content => template("sendmail/virtusertable/virtusertable.${operatingsystem}"),
        notify => Exec[sendmail_make],
        require => Package[sendmail],
        mode => 0644, owner => root, group => 0;
    }
}
