class CreateDayCollections < ActiveRecord::Migration
  def change
    create_table :day_collections do |t|
      t.integer :user_id
      t.integer :status_id
      t.integer :shift_id
      t.integer :day_id	
      t.integer :center_id
    end
  end
end
