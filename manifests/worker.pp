class xtreemfs::worker {
  # $dir_service = '192.168.57.3'

  include 'init'

  package { 'xtreemfs-backend':
    ensure  => latest,
    require => Apt::Source["xtreemfs"]
  }

  package { 'xtreemfs-server':
    ensure  => latest,
    require => Package['xtreemfs-backend']
  }

  file { '/etc/xos/xtreemfs/osdconfig.properties':
    content => template("xtreemfs/osdconfig.properties.erb"),
    owner   => 'root',
    group   => 'xtreemfs',
    mode    => '640',
    notify  => Service['xtreemfs-osd'], # sshd will restart whenever you edit this file.
    require => Package['xtreemfs-server'],
  }

  service { 'xtreemfs-dir':
    enable => false,
    ensure => stopped,
    before => Service['xtreemfs-mrc']
  }

  service { 'xtreemfs-mrc':
    enable     => false,
    ensure     => stopped,
    hasstatus  => true,
    hasrestart => true,
    before     => Service['xtreemfs-osd']
  }

  service { 'xtreemfs-osd':
    enable     => true,
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    require    => File['/etc/xos/xtreemfs/osdconfig.properties']
  }
}
