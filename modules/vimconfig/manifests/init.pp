class vimconfig ( $user = 'root' ) {

    if defined(Package['vim']) == false {
        package { "vim":
          ensure => "installed"
        }
    }

    if defined(Package['wget']) == false {
        package { "wget":
          ensure => "installed"
        }
    }

    if defined(Package['git']) == false {
        package { "git":
          ensure => "installed"
        }
    }

    if ( ( $user == '' ) or ( $user == 'root' ) ){
        $userdir = "/root/"
    } else {
        $userdir = "/home/${user}/"
    }

    $repos   = "${userdir}/repos/"
    $repodir = "${repos}/github/"
    
    file { "${repos}":
        ensure => directory
    }
    
    file { "${repodir}":
        ensure => directory
    }

    exec { "set_vim":
        command => "wget --no-check-certificate https://raw.github.com/ahluntang/vimconfig/master/install.sh -O - | sh",
        path    => [ "/usr/local/bin/", "/bin/", "/sbin/", "/usr/bin/", "/usr/sbin" ],
        cwd     => "${repodir}",
    }

}
