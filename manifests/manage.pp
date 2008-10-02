# manifests/manage.pp

# this class is used to regenerate 
# the aliases db automagically, when
# changing aliases. it should be included 
# in any main class

class sendmail::manage {

    Mailalias { 
        target => $operatingsystem ? {
            openbsd => '/etc/mail/aliases',
            default => '/etc/aliases',
        },
        require => $operatingsystem ? {
            linux => Package[sendmail],
            default => undef,
        },
        notify => Exec['newaliases'],
    }

    exec{'newaliases':
        command => '/usr/bin/newaliases',
        refreshonly => true,
        require => $operatingsystem ? {
            linux => Package[sendmail],
            default => undef,
        },
    }

    exec{sendmail_make:
        command => $kernel ? {
            openbsd => 'cd /etc/mail && /usr/bin/make',
            default => '/usr/bin/make -C /etc/mail',
        },
        refreshonly => true,
        require => $operatingsystem ? {
            linux => Package[sendmail],
            default => undef,
        },
    }
}
