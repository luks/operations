class AddAncestryToItem < ActiveRecord::Migration
  def change
    add_column :items, :ancestry, :string
  end
end
