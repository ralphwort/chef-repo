class CreateVolumes < ActiveRecord::Migration
  def change
    create_table :volumes do |t|
      t.string :name
      t.string :status
      t.string :volume_id

      t.timestamps
    end
  end
end
