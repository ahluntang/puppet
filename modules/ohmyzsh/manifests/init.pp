define ohmyzsh ( $user = $title ) {
    package { "zsh":
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
        command => "wget --no-check-certificate https://raw.github.com/ahluntang/oh-my-zsh/master/custom/install.sh -O - | bash",
        path    => [ "/usr/local/bin/", "/bin/", "/sbin/", "/usr/bin/", "/usr/sbin" ],
        cwd     => "${repodir}",
        user    => "${user}",
    }

}

