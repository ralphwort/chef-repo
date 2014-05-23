name             'my_cookbook'
maintainer       'Ralph Wort'
maintainer_email 'ralph@rwort.co.uk'
license          'All rights reserved'
description      'Installs/Configures my_cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'build-essential'
depends 'chef-client'
depends 'apache2', '>= 1.0.4'
depends 'chef_client', '>= 1.0.0'
depends 'apt', '>= 1.0.0'
depends 'ntp', '>= 1.0.0'
