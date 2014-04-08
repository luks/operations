class AddLabelToAccessories < ActiveRecord::Migration
  def change
    add_column :accessories, :label, :string
  end
end
