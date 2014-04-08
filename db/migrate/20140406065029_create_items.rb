class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :short_desc
      t.text :desc
      t.integer :location_id
      t.integer :media_id
      t.integer :type_id

      t.timestamps
    end
  end
end
