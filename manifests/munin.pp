# manifests/munin.pp

class sendmail::munin {
    munin::plugin{'sendmail': }
}
