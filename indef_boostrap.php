    <?php
    require '/vagrant/indefero/src/IDF/conf/path.php';
    require 'Pluf.php';
    Pluf::start('/vagrant/indefero/src/IDF/conf/idf.php');
    Pluf_Dispatcher::loadControllers(Pluf::f('idf_views'));
    
    $user = new Pluf_User();
    $user->first_name = 'Nikki';
    $user->last_name = 'Doe'; // Required!
    $user->login = 'doe'; // must be lowercase!
    $user->email = 'doe@example.com';
    $user->password = 'test'; // the password is salted/hashed 
                                      // in the database, so do not worry :)
    $user->administrator = true;
    $user->active = true;
    $user->create();
    print "Bootstrap ok\n";
    ?>
