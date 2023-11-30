class Location < ApplicationRecord
  has_many :searches

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def compute_score
    columns = Location.columns.select { |col| col.name.include?("info") }
    columns.each do |col|
      column = col.name
      if self.send(column) >= 3
        self.update(column => 1)
      elsif self.send(column) > 0 && self.send(column) < 3
        self.update(column => 0)
      else
        self.update(column => -1)
      end
    end
    self.save!
  end
end
