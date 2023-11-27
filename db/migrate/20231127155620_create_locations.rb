class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.string :address
      t.string :postal_code
      t.integer :supermarkets_info
      t.integer :schools_info
      t.integer :parks_info
      t.integer :nightlife_info
      t.integer :restaurants_info
      t.integer :transportation_info
      t.integer :gym_info

      t.timestamps
    end
  end
end
