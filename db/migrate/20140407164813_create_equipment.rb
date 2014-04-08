class CreateEquipment < ActiveRecord::Migration
  def change
    create_table :equipment do |t|
      t.string :key
      t.string :value
      t.integer :item_id

      t.timestamps
    end
  end
end
