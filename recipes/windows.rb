# Authors:: Sathish Kumar A M
# Cookbook:: ibmdx
# Recipe:: install
#
# Copyright:: 2019, The Authors, All Rights Reserved.

include_recipe 'windows::default'
extraction_dir=node['ibmdx']['extraction_dir']
install_extracted_dir=node['ibmdx']['install_extract_dir']
IBM_DX_version=node['ibmdx']['version']
download_url=node['ibmdx']['download_url']
IIM_repository=node['ibmdx']['iim_repository']
download_dir=node['ibmdx']['download_dir']
extraction_dir=node['ibmdx']['extraction_dir']
IIM_install_dir=node['ibmdx']['IIM_install_dir']

#CREATE DIRECTORIES FOR PORTAL SERVER
directory 'C:\\Websphere_portal_server\\Websphere_portal_extracted' do
 recursive true
end


#DOWNLOAD PORTAL ARCHIEVES
remote_files = {
  part1: { download_dir: "#{download_dir}\\IBM_WEBSPHERE_PORTAL_SERVER_INSTA.zip", url: "#{download_url}/IBM_WEBSPHERE_PORTAL_SERVER_INSTA.zip" },
  part2: { download_dir: "#{download_dir}\\IBM_WEBSPHERE_PORTAL_SERVER_SETUP.zip", url: "#{download_url}/IBM_WEBSPHERE_PORTAL_SERVER_SETUP.zip" },
  part3: { download_dir: "#{download_dir}\\WSA_Server_NetDeplo_8.5.5.2.zip", url: "#{download_url}/WSA_Server_NetDeplo_8.5.5.2.zip" },
  part4: { download_dir: "#{download_dir}\\WS_SDK_JAVA_TECH_7.0.6.1.zip", url: "#{download_url}/WS_SDK_JAVA_TECH_7.0.6.1.zip" },
  part5: { download_dir: "#{extraction_dir}\\win64", url: "#{download_url}/win64" },
}
remote_files.each_value do |files|
  remote_file files[:download_dir] do
    source files[:url]
    action :create_if_missing
  end
end

#UNZIP THE ARCHIEVE FILES
if ! Dir.exist? "#{install_extracted_dir}"
 windows_zipfile = {
   part1: { location_path: "#{download_dir}\\IBM_WEBSPHERE_PORTAL_SERVER_INSTA.zip", extract_path: "#{extraction_dir}\\" },
   part2: { location_path: "#{download_dir}\\IBM_WEBSPHERE_PORTAL_SERVER_SETUP.zip", extract_path: "#{extraction_dir}\\" },
   part3: { location_path: "#{download_dir}\\WSA_Server_NetDeplo_8.5.5.2.zip", extract_path: "#{extraction_dir}\\" },
   part4: { location_path: "#{download_dir}\\WS_SDK_JAVA_TECH_7.0.6.1.zip", extract_path: "#{extraction_dir}\\" },
 }
 windows_zipfile.each_value do |file|
  windows_zipfile file[:extract_path] do
    source file[:location_path]
    action :unzip
  end
 end
end

#USING THE TEMPLATE FOR CUSTOMIZED INSTALLATION
template "#{download_dir}\\wp85-server-and-was-windows-install.xml" do
  source 'wp85-server-and-was-windows-install.xml.erb'
end

#INSTALLING IBM INSTALLATION MANAGER
execute "imcl" do
       cwd "#{IIM_repository}\\tools\\"
       command "imcl.exe install com.ibm.cic.agent -repositories #{extraction_dir}\\win64\\repository.config -acceptlicense"
end

#INSTALLING IBM PORTAL AND THE REQUIRED COMPONENTS
execute "imcl" do
        cwd "C:\\Program Files\\IBM\\Installation Manager\\eclipse\\tools"
        command  "imcl.exe -acceptLicense input #{download_dir}\\wp85-server-and-was-install.xml  -log #{download_dir}\\portal_full_install.log"
        timeout 11200
end




