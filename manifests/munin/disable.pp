class sendmail::munin::disable inherits sendmail::munin {
    Munin::Plugin['sendmail']{
         ensure => 'absent'
    }
}
