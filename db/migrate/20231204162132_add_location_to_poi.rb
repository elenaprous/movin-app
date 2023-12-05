class AddLocationToPoi < ActiveRecord::Migration[7.1]
  def change
    add_reference :pois, :location, foreign_key: true
  end
end
