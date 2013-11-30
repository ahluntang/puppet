class ohmyzsh ( $user = 'root' ) {
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

    exec { "set_zsh":
        command => "wget --no-check-certificate https://raw.github.com/ahluntang/oh-my-zsh/master/custom/install.sh -O - | sh",
        path    => [ "/usr/local/bin/", "/bin/", "/sbin/", "/usr/bin/", "/usr/sbin" ],
        cwd     => "${repodir}",
    }

    file { "${userdir}/.oh-my-zsh":
        ensure  => 'link',
        target  => "${repodir}/oh-my-zsh",
    }

    file { "${userdir}/.zshrc":
        ensure  => 'link',
        target  => "${repodir}/oh-my-zsh/custom/zshrc",
    }


    file { "${userdir}/.bash_profile":
        ensure  => 'file',
        source  => "puppet:///files/ohmyzsh/bash_profile",
    }

}

