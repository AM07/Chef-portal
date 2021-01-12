case node['platform']
when 'redhat'
   if ( node['platform_version'] >= "7")
   include_recipe 'ibmdx::linux'
   else
        puts "Sorry your OS is not compatible to install IBMDX. Please check the OS version."
   end
when 'windows'
   if ( node['platform_version'] >= "8.1")||( node['platform_version'] >= "2012R1")
   include_recipe 'ibmdx::windows'
   else
        puts "Sorry your OS is not compatible to install IBMDX. Please check the OS version"
   end
end
