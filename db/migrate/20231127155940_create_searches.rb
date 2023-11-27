class CreateSearches < ActiveRecord::Migration[7.1]
  def change
    create_table :searches do |t|
      t.references :user, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
      t.integer :supermarket_score
      t.integer :schools_score
      t.integer :parks_score
      t.integer :nightlife_score
      t.integer :restaurants_score
      t.integer :transportation_score
      t.integer :gyms_score

      t.timestamps
    end
  end
end
