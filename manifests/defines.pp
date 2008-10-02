# manifests/sendmail/defines.pp

define sendmail::mailalias(
    $ensure = 'present',
    $recipient,
    $target = 'absent'
){
    include sendmail::newaliases

    case $target {
        'absent': { 
            $real_target = $operatingsystem ? {
                openbsd => '/etc/mail/aliases',
                default => '/etc/aliases',
            }
        }
        default: { $real_target = $target }
    }

    mailalias{"$name":
        ensure => $ensure,
        recipient => $recipient,
        target => $real_target,
        notify => Exec['refresh_aliases'],
    }
}
