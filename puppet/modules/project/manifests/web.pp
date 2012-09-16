# /support/puppet/modules/project/manifests/web.pp
class project::web {

    include apache
    include php
    include php::apache2
 

    if $params::phpmyadmin == true {
        #include project::web::phpmyadmin
        # probably do not want, rly.
    }

    include pear

    # If no version number is supplied, the latest stable release will be
    # installed. In this case, upgrade PEAR to 1.9.2+ so it can use
    # pear.drush.org without complaint.
    pear::package { "PEAR": }
    pear::package { "Console_Table": }
    pear::package { "Console_Getopt": }


}
