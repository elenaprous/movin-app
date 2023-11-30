class UpdateModels < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :supermarkets_i, :supermarkets_score
    rename_column :users, :schools_i, :schools_score
    rename_column :users, :parks_i, :parks_score
    rename_column :users, :nightlife_i, :nightlife_score
    rename_column :users, :restaurants_i, :restaurants_score
    rename_column :users, :transportation_i, :transportation_score
    rename_column :users, :gyms_i, :gyms_score
    rename_column :locations, :supermarkets_info, :supermarkets_score
    rename_column :locations, :schools_info, :schools_score
    rename_column :locations, :parks_info, :parks_score
    rename_column :locations, :nightlife_info, :nightlife_score
    rename_column :locations, :restaurants_info, :restaurants_score
    rename_column :locations, :transportation_info, :transportation_score
    rename_column :locations, :gyms_info, :gyms_score
  end
end
