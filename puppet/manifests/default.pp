# puppet/manifests/default.pp
# Set default path for Exec calls
Exec {
    path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ]
}

node default {
    include params
    include project
}
