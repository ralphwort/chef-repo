class DropFlavors < ActiveRecord::Migration
  def change
    drop_table :flavors
  end
end
