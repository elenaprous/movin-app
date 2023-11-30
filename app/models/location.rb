class Location < ApplicationRecord
  has_many :searches

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def compute_score!
    columns = Location.columns.select { |col| col.name.include?("score") }
    columns.each do |col|
      column = col.name
      value = self.send(column)
      if value.present?
        if value >= 3
          self.update(column => 1)
        elsif value > 0 && value < 3
          self.update(column => 0)
        end
      else
        self.update(column => -1)
      end
    end
    self.save!
  end
end
