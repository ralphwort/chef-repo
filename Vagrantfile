Vagrant.configure("2") do | config |
  config.vm.box = "opscode_ubuntu-12.04"
  config.vm.box_url = "file:///home/ralph/opscode_ubuntu-12.04_provisionerless.box"
  config.omnibus.chef_version = :latest
  config.vm.provision :chef_client do |chef|
    chef.provisioning_path = "/etc/chef"
    chef.chef_server_url = "https://chef.rwort.co.uk"
    chef.validation_client_name = "ralph"
    chef.validation_key_path = "/home/ralph/chef-repo/.chef/ralph.pem"
    chef.node_name = "node4"
  end
end
