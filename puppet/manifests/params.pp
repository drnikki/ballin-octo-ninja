# manifests/params.pp
class params {
    # Hostname of the virtualbox (make sure this URL points to 127.0.0.1 on your local dev system!)
    #$host = 'www.project.dev'
     $host = 'localhost'

    # Original port (don't change)
    $port = '80'

    # Database names (must match your app/config/parameters.ini file)
    $dbname = 'indefero'
    $dbuser = 'project'
    $dbpass = 'secret'

    $filepath = '/vagrant/puppet/modules'

    $phpmyadmin = true
}
