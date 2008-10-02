# manifests/munin.pp

class sendmail::munin {
    munin::plugin{'sendmail': }
}

class sendmail::munin::disable inherits sendmail::munin {
    Munin::Plugin['sendmail']{
         ensure => 'absent' 
    }
}
