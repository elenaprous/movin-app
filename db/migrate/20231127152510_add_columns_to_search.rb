class AddColumnsToSearch < ActiveRecord::Migration[7.1]
  def change
    add_column :searches, :location_id 
  end
end
