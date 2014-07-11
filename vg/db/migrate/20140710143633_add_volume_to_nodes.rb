class AddVolumeToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :volume, :string
  end
end
