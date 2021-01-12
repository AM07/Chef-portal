##################################################################
#								 #
#	Place where you can customize your installation		 #
#								 #
#								 #
#---------------------Please be carefull-------------------------#
#								 #
##################################################################
case node['platform']
when 'windows'

  #To change the directory where the binaries are getting extracted
  default['ibmdx']['extraction_dir']="C:\\Websphere_portal_server\\Websphere_portal_extracted"
  extraction_dir=node['ibmdx']['extraction_dir']

  #To change the version of product to be installed
  default['ibmdx']['version']="version8.5"
  version=node['ibmdx']['version']

  #To change the download URL
  default['ibmdx']['download_url']="http://9.124.119.172/IBMDX/#{version}"

  #Do not change this --- to check if the binaries have been extracted or not
  default['ibmdx']['install_extracted_dir']="#{extraction_dir}\\SETUP"
  install_extracted_dir=node['ibmdx']['install_extracted_dir']

  #To change the download location of the binaries
  default['ibmdx']['download_dir']="C:\\Websphere_portal_server"


  #Do not change this --- IIM repo path
  default['ibmdx']['repo_path']="IIM\\win64\\tools"
  iim_repo_path=node['ibmdx']['repo_path']

  #To change the repository location where the repository.config file is present
  default['ibmdx']['setup_repo']="#{install_extracted_dir}\\repository.config"

  #To change websphere location
  default['ibmdx']['websphere_location']="C:\\Program Files\\IBM\\WebSphere"
  websphere_location=node['ibmdx']['websphere_location']

  #To change the install location of was
  default['ibmdx']['was_install_location']="#{websphere_location}\\AppServer"

  #To change the repository location from the extracted file
  default['ibmdx']['setup_repo']="C:\\Websphere_portal_server\\Websphere_portal_extracted\\SETUP"

  #To change the portal install location
  default['ibmdx']['portal_install_location']="#{websphere_location}\\PortalServer"

  #To change the portal server Admin ID
  default['ibmdx']['portal_admin']='wpsadmin'

  #To change the portal profile name
  default['ibmdx']['wp_profile']='wp_profile'

  #To change the IIM setup repository.config directory
  default['ibmdx']['iim_repository']="#{extraction_dir}\\win64"

  #To Change IIM Installation location
  #default['ibmdx']['IIM_install_dir']="%ProgramFiles%\\IBM\\"

when 'redhat'

  #To change the user directory where your binaries are installed and extracted
  default['ibmdx']['user_name']='ibmdx'

  #To change the download location of the binary files
  default['ibmdx']['download_dir']="/home/ibmdx/download"

  #To change the path where the files are being extracted
  default['ibmdx']['extraction_dir']='/home/ibmdx/download/portal'

  #To check if the file has already been extracted or not
  default['ibmdx']['install_extracted_dir']='/home/ibmdx/download/portal/SETUP'
  install_extracted_dir=node['ibmdx']['install_extracted_dir']

  #To change the version to be installed
  default['ibmdx']['version']='version8.5'
  version=node['ibmdx']['version']

  #To change the download url
  default['ibmdx']['download_url']="http://9.124.119.172/IBMDX/#{version}"

  #To change websphere location
  default['ibmdx']['websphere_location']='/opt/IBM/WebSphere'
  websphere_location=node['ibmdx']['websphere_location']

  #To change the install location of was
  default['ibmdx']['was_install_location']="#{websphere_location}/AppServer"

  #To change the repository location from the extracted file
  default['ibmdx']['setup_repo']='/home/ibmdx/download/portal/SETUP'

  #To change the portal install location
  default['ibmdx']['portal_install_location']="#{websphere_location}/PortalServer"

  #To change the portal server Admin ID
  default['ibmdx']['portal_admin']='wpsadmin'

  #Do not change this --- the path to iim repo
  default['ibmdx']['iim_repo_path']='IIM/linux_x86_64/'
  iim_repo_path=node['ibmdx']['iim_repo_path']

  #To change the IIM setup repository.config directory
  default['ibmdx']['iim_repository']="#{install_extracted_dir}/#{iim_repo_path}"

  #Do not change this --- this is the ./imcl path for the installation and uninstallation process
  default['ibmdx']['iim_repository_imcl']="#{install_extracted_dir}/#{iim_repo_path}/tools"
                                                                                              
end













