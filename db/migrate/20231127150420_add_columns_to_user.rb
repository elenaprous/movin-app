class AddColumnsToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :important_address, :string
    add_column :users, :supermarkets_i, :integer
    add_column :users, :schools_i, :integer
    add_column :users, :parks_i, :integer
    add_column :users, :nightlife_i, :integer
    add_column :users, :restaurants_i, :integer
    add_column :users, :transportation_i, :integer
    add_column :users, :gyms_i, :integer
  end
end
