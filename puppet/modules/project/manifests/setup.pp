# /support/puppet/modules/project/manifests/setup.pp
class project::setup {

    # Install some default packages
    $default_packages = [ "mc", "strace", "sysstat", "git", "svn", "vim" ]
    package { $default_packages :
        ensure => present,
    }

}
