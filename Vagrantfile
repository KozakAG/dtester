#Vagrant.configure(2) do |config|
#  config.vm.box = "bento/ubuntu-18.04"
#  config.vm.provision "shell", path: "provision.sh"
# end

BOX_IMAGE = "bento/ubuntu-18.04"
Vagrant.configure("2") do |config|
        config.vm.define "app" do |subconfig|
            subconfig.vm.provider "virtualbox" do |v|
                v.name = "app_vm"
            end
            subconfig.vm.box = BOX_IMAGE
            subconfig.vm.network "private_network", ip: "192.168.63.100"

            subconfig.vm.provider "virtualbox" do |vb|
                vb.memory = "2048"
                vb.cpus = "1"
            end
            subconfig.vm.provision :shell, path: "php_fpm_.sh"
            subconfig.vm.provision :shell, path: "app_sh_.sh"
			
        end
		
		config.vm.define "app1" do |subconfig|
            subconfig.vm.provider "virtualbox" do |v|
                v.name = "app1_vm"
            end
            subconfig.vm.box = BOX_IMAGE
            subconfig.vm.network "private_network", ip: "192.168.63.200"

            subconfig.vm.provider "virtualbox" do |vb|
                vb.memory = "2048"
                vb.cpus = "1"
            end
            subconfig.vm.provision :shell, path: "php_fpm_.sh"
            subconfig.vm.provision :shell, path: "app_sh_.sh"
            subconfig.vm.provision :shell, path: "bld_vm_.sh"
			
        end

        config.vm.define "db" do |subconfig|
            subconfig.vm.provider "virtualbox" do |v|
                v.name = "db_vm"
            end
            subconfig.vm.box = BOX_IMAGE
            subconfig.vm.network "private_network", ip: "192.168.63.50"

            subconfig.vm.provider "virtualbox" do |vb|
                vb.memory = "1024"
                vb.cpus = "1"
            end
            subconfig.vm.provision :shell, path: "db_vm.sh"
        end
		
	        config.vm.define "lb" do |subconfig|
            subconfig.vm.provider "virtualbox" do |v|
                v.name = "lb_vm"
            end
            subconfig.vm.box = BOX_IMAGE
            subconfig.vm.network "private_network", ip: "192.168.63.150"

            subconfig.vm.provider "virtualbox" do |vb|
                vb.memory = "1024"
                vb.cpus = "1"
            end
            subconfig.vm.provision :shell, path: "lb_vm.sh"
        end	
end