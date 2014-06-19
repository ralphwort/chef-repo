class AddApps2ToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :apps, :string
  end
end
