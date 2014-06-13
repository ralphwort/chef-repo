class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.integer :openstack_user_id
      t.string :name
      t.string :recipe

      t.timestamps
    end
  end
end
