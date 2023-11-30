class AddRankingToSearch < ActiveRecord::Migration[7.1]
  def change
    add_column :searches, :ranking, :integer
  end
end
