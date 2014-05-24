name             'rails_server'
maintainer       'Ralph Wort'
maintainer_email 'ralph@rwort.co.uk'
license          'All rights reserved'
description      'Installs/Configures rails_server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "curl"
depends "passenger_apache2"
