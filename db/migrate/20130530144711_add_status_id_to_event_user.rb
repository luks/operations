class AddStatusIdToEventUser < ActiveRecord::Migration
  def change
    add_column :eventusers, :status_id, :integer
  end
end
