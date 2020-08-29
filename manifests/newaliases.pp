# refresh newaliases file
class sendmail::newaliases {
  Exec<| title == 'manage_alternatives_mta' |> ->
  exec{'refresh_aliases':
    command     => 'newaliases',
    refreshonly => true,
  }
}
