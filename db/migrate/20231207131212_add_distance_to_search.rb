class AddDistanceToSearch < ActiveRecord::Migration[7.1]
  def change
    add_column :searches, :distance_score, :integer
  end
end
