class CreatePois < ActiveRecord::Migration[7.1]
  def change
    create_table :pois do |t|
      t.string :address
      t.string :name
      t.string :category
      t.float :lat
      t.float :lon

      t.timestamps
    end
  end
end
