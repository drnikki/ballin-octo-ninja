# /puppet/modules/project/manifests/init.pp
class project {
  ## top block to call apt-get update at least once ##
  include apt::update
  Exec { path => ['/usr/local/bin', '/opt/local/bin', '/usr/bin', '/usr/sbin', '/bin', '/sbin'], logoutput => true }
  Exec["apt_update"] -> Package <| |>
  ## end top block ##


    include project::setup
    include project::sql
    include project::web
    include project::indefero
    #include project::symfony2
}
