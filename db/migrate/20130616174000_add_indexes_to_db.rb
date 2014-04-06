class AddIndexesToDb < ActiveRecord::Migration
  def change

  	add_index :day_collections, :day_id
  	add_index :day_collections, :status_id
  	add_index :day_collections, :shift_id
  	add_index :day_collections, :center_id
  	add_index :day_collections, :user_id

  	add_index :days, :date

  end
end
