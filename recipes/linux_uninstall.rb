# Author:: Sathish Kumar A M
# recipe:: uninstall
#
# Cookbook:: ibmdx
#
# Copyright:: 2019, Sathish Kumar A M, All Rights Reserved.



#EXECUTING IMCL TO UNINSTALL IBM PORTALL AND WAS
execute "imcl" do
  cwd "/opt/IBM/InstallationManager/eclipse/tools"
  command "./imcl uninstall com.ibm.websphere.IBMJAVA.v70_7.0.6001.20140324_2202 com.ibm.websphere.ND.v85_8.5.5002.20140408_1947 8.5.5.0-WS-WASProd-IFPI15756_8.5.5000.20140411_1012 8.5.5.2-WS-WAS-IFPI15581_8.5.5002.20140411_1052 com.ibm.websphere.PORTAL.SERVER.v85_8.5.0.20140424_2155"
end

#UNINSTALLING INSTALLATION MANAGER
execute "imcl" do
  cwd "/opt/IBM/InstallationManager/eclipse/tools"
  command "./imcl uninstall com.ibm.cic.agent"
end

#DELETING THE USER AND DIRECTORIES CREATED BY WAS IF ALL THE COMPONENTS OF WAS IS INSTALLED CORRECTLY
if ! File.exist? "#{was_install_location}/bin/serverStatus.sh"
 directory "#{websphere_location}" do
  recursive true
  action :remove
 end
 directory "/opt/IBM/InstallationManager" do
   recursive true
   action :remove
 end
 user "#{user}" do
        group "wheel"
        manage_home true
        system true
        action :remove
 end
end 
