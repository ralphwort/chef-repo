class AddSigningKeyFileToOpenstackUsers < ActiveRecord::Migration
  def change
    add_column :openstack_users, :signing_key_file, :string
  end
end
