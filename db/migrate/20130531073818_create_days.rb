class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.date :date
      t.integer :center_id
      t.timestamps
    end
    add_index :days, :id
  end
end
