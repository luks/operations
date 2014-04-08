class AddCapacityToItem < ActiveRecord::Migration
  def change
    add_column :items, :capacity, :integer
  end
end
