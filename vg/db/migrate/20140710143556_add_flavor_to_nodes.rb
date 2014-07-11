class AddFlavorToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :flavor, :string
  end
end
