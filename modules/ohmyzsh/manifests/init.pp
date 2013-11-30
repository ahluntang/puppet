class ohmyzsh ( $user = 'root' ) {

    if defined(Package['zsh']) == false {
        package { "zsh":
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
    
    if defined(File['${repos}']) == false {
        file { "${repos}":
            ensure => directory
        }
    }
    
    if defined(File['${repodir}']) == false {
        file { "${repodir}":
            ensure => directory
        }
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

