# manifests/manage.pp

# this class is used to regenerate 
# the aliases db automagically, when
# changing aliases. it should be included 
# in any main class

class sendmail::manage {

    Mailalias { 
        target => '/etc/aliases',
        require => $operatingsystem ? {
            linux => Package[sendmail],
        },
        notify => Exec['newaliases'],
    }

    exec{'newaliases':
        command => '/usr/bin/newaliases',
        refreshonly => true,
        require => $operatingsystem ? {
            linux => Package[sendmail],
        },
    }

    exec{sendmail_make:
        command => '/usr/bin/make -C /etc/mail',
        refreshonly => true,
        require => $operatingsystem ? {
            linux => Package[sendmail],
        },
    }
}
