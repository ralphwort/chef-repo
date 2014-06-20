class CreateFlavors < ActiveRecord::Migration
  def change
    create_table :flavors do |t|
      t.string :name
      t.string :flavor_id

      t.timestamps
    end
  end
end
