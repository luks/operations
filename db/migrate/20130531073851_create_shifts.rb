class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.string :name
      t.string :shift
      t.datetime :start_time
      t.datetime :end_time
      t.timestamps
    end
  end
end
