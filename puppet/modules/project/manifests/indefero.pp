# indefero
class project::indefero {
 
      exec { "create-${name}-db":
        unless => "/usr/bin/mysql -u${params::dbuser} -p${params::dbpassword} ${params::dbname}",
        command => "/usr/bin/mysql -uroot -p$mysql_password -e \"create database ${params::dbname}; grant all on ${params::dbname}.* to ${params::dbuser}@localhost identified by '${params::dbpassword}';\"",
        require => Service["mysql"],
      }



#cd /vagrant/indefero/src/
#vagrant@precise32:/vagrant/indefero/src$ php /vagrant/pluf/src/migrate.php --conf=IDF/conf/idf.php -a -i -d -u

}
