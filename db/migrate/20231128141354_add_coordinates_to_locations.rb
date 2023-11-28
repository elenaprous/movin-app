class AddCoordinatesToLocations < ActiveRecord::Migration[7.1]
  def change
    add_column :locations, :latitude, :float
    add_column :locations, :longitude, :float
  end
end
