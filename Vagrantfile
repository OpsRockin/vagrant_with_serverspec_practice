# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

@chefzero_ip = '10.33.33.100'

def box_and_omnibus(config)
  config.vm.box = 'opscode-ubuntu-12.04'
  config.vm.box_url = 'http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-12.04_chef-provisionerless.box'
  config.omnibus.chef_version = :latest
end

def setup_chef_client(config, &block)
  config.vm.provision :chef_client do |chef|
    chef.log_level = :info
    chef.environment = 'sandbox' ## example's default
    chef.chef_server_url = "http://#{@chefzero_ip}"
    chef.validation_key_path = File.expand_path('../.chef/dummy.pem' , __FILE__)
    chef.add_recipe 'recipe[simplelog_handler::default]'

    yield(chef) if block_given?
  end
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  ## ChefZero VM
  config.vm.define :chefzero do |chefzero|
    chefzero.vm.hostname = 'chefzero'
    chefzero.vm.network :private_network, ip: @chefzero_ip
    box_and_omnibus(chefzero)

    config.vm.provider :virtualbox do |vb|
      vb.memory = 1024
    end

    chefzero.vm.provision :chef_solo do |cz|
      cz.cookbooks_path = ['./cookbooks']
      cz.add_recipe 'recipe[chef-zero::default]'
      cz.json = {
        "chef-zero" => {
          "version" => '2.0.2',
          "install" => true,
          "start"   => true
        }
      }
    end
  end

  ## Sandbox VM
  config.vm.define :sandbox do |config|
    config.vm.hostname = 'sandbox'
    config.vm.network :private_network, ip: '10.33.33.101'
    box_and_omnibus(config)

    config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--cpus", "2"]
      vb.memory = 1024
    end

    setup_chef_client(config) do |chef|
      chef.add_role 'role[sample_role]'
      chef.json = {
      }
    end
  end

end
