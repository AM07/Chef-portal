name 'ibmdx'
maintainer 'Sathish Kumar A M'
maintainer_email 'sakumar1@in.ibm.com'
license 'All Rights Reserved'
description 'Installs/Configures ibmdx'
long_description 'Installs/Configures ibmdx'
version '0.1.0'
chef_version '>= 13.0'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
issues_url 'https://github.ibm.com/AppOpsIaaCChef/IBMDX/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
source_url 'https://github.ibm.com/AppOpsIaaCChef/IBMDX'


#This cookbook is dependend on the zipfile cookbook
depends 'ibmdx'
depends 'zipfile'
depends 'windows'
