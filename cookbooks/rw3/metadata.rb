name             'rw3'
maintainer       'Ralph Wort'
maintainer_email 'ralph@rwort.co.uk'
license          'All rights reserved'
description      'Installs/Configures rw3'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "ruby_build"
depends "nginx"
depends "passenger", "4.0.42"
