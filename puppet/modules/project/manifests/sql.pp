# puppet/modules/project/manifests/sql.pp
class project::sql {
    include mysql
    
  
    package { "mysql-server": }
    package { "php5-mysql": }

    service { "mysql":
        ensure => "running",
        enable => "true",
        require => Package["mysql-server"],
    }


}


# http://www.adayinthelifeof.nl/2012/06/29/using-vagrant-and-puppet-to-setup-your-symfony2-environment/
