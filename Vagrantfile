# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

def box_and_omnibus(config)
  config.vm.box = 'opscode-ubuntu-12.04'
  config.vm.box_url = 'http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-12.04_chef-provisionerless.box'
  config.omnibus.chef_version = :latest
end

def setup_chef_solo(config, &block)
  config.vm.provision :chef_solo do |chef|
    chef.log_level = :info
    chef.cookbooks_path = ['./cookbooks', './site-cookbooks']
    chef.add_recipe 'recipe[simplelog_handler::default]'

    yield(chef) if block_given?
  end
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  ## Serverspec VM
  config.vm.define :serverspec do |svs|
    svs.vm.hostname = 'serverspec'
    svs.vm.network :private_network, ip: '10.33.34.100'
    config.vm.network :forwarded_port, guest: 80, host: 8080
    
    box_and_omnibus(svs)

    config.vm.provider :virtualbox do |vb|
      vb.memory = 1024
    end

    svs.vm.provision :chef_solo do |ss|
      ss.cookbooks_path = ['./cookbooks']
      ss.add_recipe 'recipe[omnibus_serverspec::default]'
      ss.json = {
      }
    end
  end

  ## Sandbox VM
  config.vm.define :sandbox do |config|
    config.vm.hostname = 'sandbox'
    config.vm.network :private_network, ip: '10.33.34.101'
    config.vm.network :forwarded_port, guest: 80, host: 8080
    box_and_omnibus(config)

    config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--cpus", "2"]
      vb.memory = 1024
    end

    setup_chef_solo(config) do |chef|
      chef.add_recipe 'recipe[dummy::default]'
      chef.json = {
      }
    end
  end

end
