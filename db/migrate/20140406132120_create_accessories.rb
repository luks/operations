class CreateAccessories < ActiveRecord::Migration
  def change
    create_table :accessories do |t|
      t.string :key
      t.text :value
      t.integer :item_id

      t.timestamps
    end
  end
end
