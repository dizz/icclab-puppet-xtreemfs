class xtreemfs::aio {
  include 'init'

  package { 'xtreemfs-backend':
    ensure  => latest,
    require => Apt::Source["xtreemfs"]
  }

  package { 'xtreemfs-server':
    ensure  => latest,
    require => Package['xtreemfs-backend']
  }

  package { 'xtreemfs-client': ensure => latest }

  service { 'xtreemfs-dir':
    enable     => true,
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    before     => Service['xtreemfs-mrc']
  }

  service { 'xtreemfs-mrc':
    enable     => true,
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    before     => Service['xtreemfs-osd']
  }

  service { 'xtreemfs-osd':
    enable     => true,
    ensure     => running,
    hasstatus  => true,
    hasrestart => true
  }

}