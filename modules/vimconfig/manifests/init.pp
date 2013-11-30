class vimconfig {
    package { "vim":
        ensure  => "installed"
    }

    package { "wget":
        ensure  => "installed"
    }

    package { "git":
        ensure  => "installed"
    }

    if ( ( $title == '' ) or ( $title == 'root' ) ){
        $repodir = "/root/repos/github"
    } else {
        $repodir = "/home/${title}/repos/github"
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
