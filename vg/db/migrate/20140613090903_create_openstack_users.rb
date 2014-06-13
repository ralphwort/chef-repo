class CreateOpenstackUsers < ActiveRecord::Migration
  def change
    create_table :openstack_users do |t|
      t.string :os_username
      t.string :os_password
      t.string :os_auth_url

      t.timestamps
    end
  end
end
