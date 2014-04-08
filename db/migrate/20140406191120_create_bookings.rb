class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.datetime :from
      t.datetime :till
      t.integer :item_id
      t.integer :user_id

      t.timestamps
    end
  end
end
