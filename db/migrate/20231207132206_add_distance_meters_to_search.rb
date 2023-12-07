class AddDistanceMetersToSearch < ActiveRecord::Migration[7.1]
  def change
    add_column :searches, :distance, :integer
  end
end
