class AddClientNameToOpenstackUsers < ActiveRecord::Migration
  def change
    add_column :openstack_users, :client_name, :string
  end
end
