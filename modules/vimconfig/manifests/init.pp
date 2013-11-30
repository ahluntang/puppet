define vimconfig ( $user = $title ) {
    package { "vim":
        ensure  => "installed"
    }

    package { "wget":
        ensure  => "installed"
    }

    package { "git":
        ensure  => "installed"
    }

    if ( ( $user == '' ) or ( $user == 'root' ) ){
        $repos   = "/root/repos/"
        $repodir = "/root/repos/github/"
    } else {
        $repos   = "/home/${user}/repos/"
        $repodir = "/home/${user}/repos/github/"
    }
    
    file { "${repos}":
        ensure => directory
    }
    
    file { "${repodir}":
        ensure => directory
    }

    exec { "set_vim":
        command => "wget --no-check-certificate https://raw.github.com/ahluntang/vimconfig/master/install.sh -O - | bash",
        path    => [ "/usr/local/bin/", "/bin/", "/sbin/", "/usr/bin/", "/usr/sbin" ],
        cwd     => "${repodir}",
    }

}
