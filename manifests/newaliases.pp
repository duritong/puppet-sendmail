# manifests/classes/newaliases.pp

class sendmail::newaliases {
    exec{'refresh_aliases':
        command => 'newaliases',
        refreshonly => true,
    }
}
