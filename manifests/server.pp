#
#
#
class profile_nfs::server (
  Stdlib::AbsolutePath $mount_dir             = $::profile_nfs::mount_dir,
  String               $data_device           = $::profile_nfs::data_device,
  String               $domain                = $::profile_nfs::domain,
  String               $export_root           = $::profile_nfs::export_root,
  String               $root_clients          = $::profile_nfs::root_clients,
  Boolean              $manage_firewall_entry = $::profile_nfs::manage_firewall_entry,
  Hash                 $exports               = $::profile_nfs::exports,
  Hash                 $export_defaults       = $::profile_nfs::export_defaults,
  Boolean              $nfs_backup            = $::profile_nfs::nfs_backup,
) {
  profile_base::mount{ $mount_dir:
    device => $data_device,
    mkdir  => false,
    mkfs   => false,
    before => Class['nfs'],
  }

  class { 'nfs':
    server_enabled             => true,
    nfs_v4                     => true,
    nfs_v4_idmap_domain        => $domain,
    nfs_v4_export_root         => $export_root,
    nfs_v4_export_root_clients => $root_clients,
  }

  if $manage_firewall_entry {
    firewall { '00111 allow rpcbind TCP':
      dport  => 111,
      action => 'accept',
      proto  => 'tcp',
    }
    firewall { '00111 allow rpcbind UDP':
      dport  => 111,
      action => 'accept',
      proto  => 'udp',
    }
    firewall { '02049 allow nfs TCP':
      dport  => 2049,
      action => 'accept',
      proto  => 'tcp',
    }
    firewall { '02049 allow nfs UDP':
      dport  => 2049,
      action => 'accept',
      proto  => 'udp',
    }
  }
  create_resources( nfs::server::export, $exports, $export_defaults )

  if $nfs_backup {
    include profile_nfs::backup
  }
}
