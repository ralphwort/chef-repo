log_level                :info
log_location             STDOUT
node_name                'ralph'
client_key               '/home/ralph/chef-repo/.chef/ralph.pem'
validation_client_name   'chef-validator'
validation_key           '/home/ralph/chef-repo/.chef/chef-validator.pem'
chef_server_url          'https://chef.rwort.co.uk:443'
syntax_check_cache_path  '/home/ralph/chef-repo/.chef/syntax_check_cache'
cookbook_path [ '/home/ralph/chef-repo/cookbooks' ]
