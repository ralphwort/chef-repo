class AddIpaddressToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :ipaddress, :string
  end
end
