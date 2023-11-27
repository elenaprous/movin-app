class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.string :address
      t.string :postal_code
      t.string :supermarkets_info
      t.string :schools_info
      t.string :parks_info
      t.string :nightlife_info
      t.string :restaurants_info
      t.string :transportation_info
      t.string :gym_info

      t.timestamps
    end
  end
end
