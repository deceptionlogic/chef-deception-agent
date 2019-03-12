name              'deceptionagent'
maintainer        'Deception Logic'
license           'MIT'
description       'Installs and configures deception agent'

%w( rhel centos debian ubuntu ).each do |os|
  supports os
end

