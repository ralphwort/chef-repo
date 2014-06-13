class AddChefServerUrlToOpenstackUsers < ActiveRecord::Migration
  def change
    add_column :openstack_users, :chef_server_url, :string
  end
end
