# rhel6
if node['platform_family'] == 'rhel' && node['platform_version'].match(/6.*/)
  package 'yum-utils'
  package 'pygpgme'
  package 'wget'

  execute 'add_gpg_key' do
    command "/bin/rpm --import 'https://dl.deceptionlogic.net/public/deception-agent/cfg/gpg/gpg.3812E46CD5C4E4A6.key'"
  end
  execute 'retrieve_repo' do
    command "/usr/bin/wget -q 'https://dl.deceptionlogic.net/public/deception-agent/cfg/setup/config.rpm.txt?codename=6&distro=el' -O /tmp/deception-logic-deception-agent.repo"
  end
  execute  'add repo' do
    command '/usr/bin/yum-config-manager --add-repo /tmp/deception-logic-deception-agent.repo'
  end
  execute  'install deception-agent' do
    command '/usr/bin/yum install -y --nogpgcheck deception-agent'
  end

  directory '/etc/deceptionlogic/' do
    path '/etc/deceptionlogic/'
    owner 'root'
    group 'root'
    mode '0755'
  end

  template 'deception-agent configuration file' do
    source 'agent.conf.erb'
    path "/etc/deceptionlogic/agent.conf"
    owner 'root'
    group 'root'
  end

  service 'deception-agent' do
    action [:enable,:start]
  end

end

# rhel7
if node['platform_family'] == 'rhel' && node['platform_version'].match(/7.*/)
  package 'yum-utils'
  package 'pygpgme'
  package 'wget'

  execute 'add_gpg_key' do
    command "/usr/bin/rpm --import 'https://dl.deceptionlogic.net/public/deception-agent/cfg/gpg/gpg.3812E46CD5C4E4A6.key'"
  end
  execute 'retrieve_repo' do
    command "/usr/bin/wget -q 'https://dl.deceptionlogic.net/public/deception-agent/cfg/setup/config.rpm.txt?codename=7&distro=el' -O /tmp/deception-logic-deception-agent.repo"
  end
  execute  'add repo' do
    command '/usr/bin/yum-config-manager --add-repo /tmp/deception-logic-deception-agent.repo'
  end
  execute  'install deception-agent' do
    command '/usr/bin/yum install -y --nogpgcheck deception-agent'
  end

  directory '/etc/deceptionlogic/' do
    path '/etc/deceptionlogic/'
    owner 'root'
    group 'root'
    mode '0755'
  end

  template 'deception-agent configuration file' do
    source 'agent.conf.erb'
    path "/etc/deceptionlogic/agent.conf"
    owner 'root'
    group 'root'
  end

  service 'deception-agent' do
    action [:enable,:start]
  end
end

# jessie
if node['platform'] == 'debian' && node['platform_version'].match(/8.*/)
  
  execute 'update_cache' do
    command "/usr/bin/apt-get update"
  end
  
  package 'apt-transport-https'
  package 'debian-keyring'
  package 'debian-archive-keyring'

  execute 'add_gpg_key' do
    command "/usr/bin/curl -1sLf 'https://dl.deceptionlogic.net/public/deception-agent/cfg/gpg/gpg.3812E46CD5C4E4A6.key' | apt-key add -"
  end
  execute 'add_repo' do
    command "/usr/bin/curl -1sLf 'https://dl.deceptionlogic.net/public/deception-agent/cfg/setup/config.deb.txt?codename=jessie&distro=debian' > /etc/apt/sources.list.d/deception-logic-deception-agent.list"
  end
  execute 'update_cache' do
    command '/usr/bin/apt-get update'
  end
  package 'deception-agent'

  directory '/etc/deceptionlogic/' do
    path '/etc/deceptionlogic/'
    owner 'root'
    group 'root'
    mode '0755'
  end

  template 'deception-agent configuration file' do
    source 'agent.conf.erb'
    path "/etc/deceptionlogic/agent.conf"
    owner 'root'
    group 'root'
  end

  service 'deception-agent' do
    action [:enable,:start]
  end
end

# stretch
if node['platform'] == 'debian' && node['platform_version'].match(/9.*/)

  execute 'update_cache' do
    command '/usr/bin/apt-get update'
  end

  package 'apt-transport-https'
  package 'debian-keyring'
  package 'debian-archive-keyring'

  execute 'add_gpg_key' do
    command "/usr/bin/curl -1sLf 'https://dl.deceptionlogic.net/public/deception-agent/cfg/gpg/gpg.3812E46CD5C4E4A6.key' | apt-key add -"
  end
  execute 'add_repo' do
    command "/usr/bin/curl -1sLf 'https://dl.deceptionlogic.net/public/deception-agent/cfg/setup/config.deb.txt?codename=stretch&distro=debian' > /etc/apt/sources.list.d/deception-logic-deception-agent.list"
  end
  execute 'update_cache' do
    command '/usr/bin/apt-get update'
  end
  package 'deception-agent'

  directory '/etc/deceptionlogic/' do
    path '/etc/deceptionlogic/'
    owner 'root'
    group 'root'
    mode '0755'
  end

  template 'deception-agent configuration file' do
    source 'agent.conf.erb'
    path "/etc/deceptionlogic/agent.conf"
    owner 'root'
    group 'root'
  end

  service 'deception-agent' do
    action [:enable,:start]
  end
end

# trusty 14.04
if node['platform'] == 'ubuntu' && node['platform_version'] == '14.04'

  execute 'update_cache' do
    command "/usr/bin/apt-get update"
  end

  execute 'install_dependencies' do
    command "/usr/bin/apt-get install -y apt-transport-https debian-keyring debian-archive-keyring"
  end

  execute 'add_gpg_key' do
    command "/usr/bin/curl -1sLf 'https://dl.deceptionlogic.net/public/deception-agent/cfg/gpg/gpg.3812E46CD5C4E4A6.key' | apt-key add -"
  end

  execute 'add_repo' do
    command "/usr/bin/curl -1sLf 'https://dl.deceptionlogic.net/public/deception-agent/cfg/setup/config.deb.txt?codename=trusty&distro=ubuntu' > /etc/apt/sources.list.d/deception-logic-deception-agent.list"
  end
  execute 'update_cache' do
    command "/usr/bin/apt-get update"
  end
  package 'deception-agent'

  directory '/etc/deceptionlogic/' do
    path '/etc/deceptionlogic/'
    owner 'root'
    group 'root'
    mode '0755'
  end

  template 'deception-agent configuration file' do
    source 'agent.conf.erb'
    path "/etc/deceptionlogic/agent.conf"
    owner 'root'
    group 'root'
  end

  service 'deception-agent' do
    action [:enable,:start]
  end
end

# xenial
if node['platform'] == 'ubuntu' && node['platform_version'] == '16.04'

  execute 'update_cache' do
    command "/usr/bin/apt-get update"
  end

  package 'apt-transport-https'
  package 'debian-keyring'
  package 'debian-archive-keyring'

  execute 'add_gpg_key' do
    command "/usr/bin/curl -1sLf 'https://dl.deceptionlogic.net/public/deception-agent/cfg/gpg/gpg.3812E46CD5C4E4A6.key' | apt-key add -"
  end

  execute 'add_repo' do
    command "/usr/bin/curl -1sLf 'https://dl.deceptionlogic.net/public/deception-agent/cfg/setup/config.deb.txt?codename=xenial&distro=ubuntu' > /etc/apt/sources.list.d/deception-logic-deception-agent.list"
  end
  execute 'update_cache' do
    command "/usr/bin/apt-get update"
  end
  package 'deception-agent'

  directory '/etc/deceptionlogic/' do
    path '/etc/deceptionlogic/'
    owner 'root'
    group 'root'
    mode '0755'
  end

  template 'deception-agent configuration file' do
    source 'agent.conf.erb'
    path "/etc/deceptionlogic/agent.conf"
    owner 'root'
    group 'root'
  end

  service 'deception-agent' do
    action [:enable,:start]
  end
end

# artful
if node['platform'] == 'ubuntu' && node['platform_version'] == '17.10'
  
  execute 'update_cache' do
    command "/usr/bin/apt-get update"
  end

  package 'apt-transport-https'
  package 'debian-keyring'
  package 'debian-archive-keyring'

  execute 'add_gpg_key' do
    command "/usr/bin/curl -1sLf 'https://dl.deceptionlogic.net/public/deception-agent/cfg/gpg/gpg.3812E46CD5C4E4A6.key' | apt-key add -"
  end

  execute 'add_repo' do
    command "/usr/bin/curl -1sLf 'https://dl.deceptionlogic.net/public/deception-agent/cfg/setup/config.deb.txt?codename=artful&distro=ubuntu' > /etc/apt/sources.list.d/deception-logic-deception-agent.list"
  end
  execute 'update_cache' do
    command "/usr/bin/apt-get update"
  end
  package 'deception-agent'

  directory '/etc/deceptionlogic/' do
    path '/etc/deceptionlogic/'
    owner 'root'
    group 'root'
    mode '0755'
  end

  template 'deception-agent configuration file' do
    source 'agent.conf.erb'
    path "/etc/deceptionlogic/agent.conf"
    owner 'root'
    group 'root'
  end

  service 'deception-agent' do
    action [:enable,:start]
  end
end
