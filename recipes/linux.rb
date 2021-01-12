# Author:: Sathish Kumar A M
# Cookbook:: ibmdx
# Recipe:: linux
#
# Copyright:: 2019, Sathish Kumar A M, All Rights Reserved.


#DECLARE RUBY VARIABLES
user=node['ibmdx']['user_name']
extraction_dir=node['ibmdx']['extraction_dir']
install_extracted_dir=node['ibmdx']['install_extract_dir']
IBM_DX_version=node['ibmdx']['version']
download_url=node['ibmdx']['download_url']
IIM_repository=node['ibmdx']['iim_repository_imcl']
download_dir=node['ibmdx']['download_dir']
iim_config_file_path=node['ibmdx']['iim_repository']

#CREATE A NEW USER IBMDX AND PROVIDE ROOT ACCESS
user "#{user}" do
        group "wheel"
        manage_home true
        system true        
end

#CREATE DIRECTORIES
directory "/home/ibmdx/download/portal" do
 recursive true
end

#DOWNLOAD THE REQUIRED PACKAGES
remote_files = {
  part1: { download_dir: "#{download_dir}/IBM_WEBSPHERE_PORTAL_SERVER_INSTA.zip", url: "#{download_url}/IBM_WEBSPHERE_PORTAL_SERVER_INSTA.zip" },
  part2: { download_dir: "#{download_dir}/IBM_WEBSPHERE_PORTAL_SERVER_SETUP.zip", url: "#{download_url}/IBM_WEBSPHERE_PORTAL_SERVER_SETUP.zip" },
  part3: { download_dir: "#{download_dir}/WSA_Server_NetDeplo_8.5.5.2.zip", url: "#{download_url}/WSA_Server_NetDeplo_8.5.5.2.zip" },
  part4: { download_dir: "#{download_dir}/WS_SDK_JAVA_TECH_7.0.6.1.zip", url: "#{download_url}/WS_SDK_JAVA_TECH_7.0.6.1.zip" },
}
remote_files.each_value do |files|
  remote_file files[:download_dir] do
     source files[:url]
  end
end

#UNZIP THE BINARIES
if ! Dir.exist? "#{extraction_dir}/SETUP"
 zipfile = {
   file1: { location_path: "#{download_dir}/IBM_WEBSPHERE_PORTAL_SERVER_INSTA.zip", extract_path: "#{extraction_dir}/" },
   file2: { location_path: "#{download_dir}/IBM_WEBSPHERE_PORTAL_SERVER_SETUP.zip", extract_path: "#{extraction_dir}/" },
   file3: { location_path: "#{download_dir}/WSA_Server_NetDeplo_8.5.5.2.zip", extract_path: "#{extraction_dir}/" },
   file4: { location_path: "#{download_dir}/WS_SDK_JAVA_TECH_7.0.6.1.zip", extract_path: "#{extraction_dir}/" },
 }
 zipfile.each_value do |extraction|
  zipfile extraction[:location_path] do
    into extraction[:extract_path]
    action :create_if_missing
  end
 end
end

#USING THE TEMPLATE FOR CUSTOMIZED INSTALLATION
template "#{download_dir}/wp85-server-and-was-linux-install.xml" do
  source 'wp85-server-and-was-linux-install.xml.erb'
end

#INSTALLING INSTALLATION MANAGER
execute "imcl" do
       cwd "#{IIM_repository}"
       command "./imcl install com.ibm.cic.agent -repositories #{iim_config_file_path}/repository.config -acceptlicense"
end

#INSTALLING IBM PORTAL AND THE REQUIRED 
execute "imcl" do
        cwd "/opt/IBM/InstallationManager/eclipse/tools"
        command  "./imcl -acceptLicense input #{download_dir}/wp85-server-and-was-install.xml  -log /tmp/portal_full_install.log"
        timeout 7200
end


