name             'sensu-checks'
maintainer       'Nick Veenhof'
maintainer_email 'nick.veenhof@gmail.com'
license          'All rights reserved'
description      'Installs/Configures sensu-checks'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends          'sensu'
depends          'logrotate'