class AddAncestryToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :ancestry, :string
  end
end
