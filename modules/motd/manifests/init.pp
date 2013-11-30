class motd {
    package { "bc":
        ensure  => "installed"
    }
    
    file { "/usr/local/bin/motd_stats.sh":
        source  => "puppet:///files/motd/motd_stats.sh",
        ensure  => file,
        mode    => 755
    }

    file { "/root/motd/":
        ensure => directory
    }

    file { "/root/motd/motd.email":
        source  => "puppet:///files/motd/motd.email",
        ensure  => file
    }

    file { "/root/motd/motd.api":
        source  => "puppet:///files/motd/motd.api",
        ensure  => file
    }

    file { "/etc/ssh/ssh_banner":
        source  => "puppet:///files/ssh/ssh_banner",
        ensure  => file,
    }

    cron { "update_cron":
        ensure  => 'present',
        command => '/usr/local/bin/motd_stats.sh',
        user    => 'root',
        hour    => "*",
        minute  => "*/5"
    }

}

