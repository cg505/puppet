class ocf_puppet {
  include ocf::ssl::default
  include ocf_puppet::environments
  include ocf_puppet::firewall_input
  include ocf_puppet::puppetboard
  include ocf_puppet::puppetserver

  file { '/etc/sudoers.d/ocfdeploy-puppet':
    content => "ocfdeploy ALL=NOPASSWD: /opt/puppetlabs/scripts/update-prod\n";
  }

  file { '/usr/local/bin/write-otp-config':
    source  => 'puppet:///modules/ocf_puppet/write-otp-config',
    mode    => '0700',
    require => Package['libpam-google-authenticator'];
  }

  package {
    # Keychain is useful for managing SSH and GPG agents
    'keychain':;

    # Staff need to use virtualenv to run tests.
    'virtualenv':;
  }
}
