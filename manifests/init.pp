# Class: xtreemfs
#
# This module manages xtreemfs
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class xtreemfs::init {
  apt::source { 'xtreemfs':
    location          => "http://download.opensuse.org/repositories/home:/xtreemfs/xUbuntu_11.10/",
    release           => "./",
    repos             => "",
    include_src       => false,
    required_packages => "debian-keyring debian-archive-keyring",
    key               => '2FA7E736',
    key_source        => "http://download.opensuse.org/repositories/home:/xtreemfs/xUbuntu_11.10/Release.key",
  }

}

