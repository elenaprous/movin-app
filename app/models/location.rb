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

  def location_scores!
    places = HTTParty.get("https://api.tomtom.com/search/2/nearbySearch/.json\?key\=#{ENV["TOM_TOM_KEY"]}\&lat\=#{self.latitude}\&lon\=#{self.longitude}\&radius\=500\&limit\=100")["results"]

    self.supermarkets_score = places.count { |place| place["poi"]["categories"].include?("shop") }

    self.schools_score = places.count { |place| place["poi"]["categories"].include?("school") }

    self.restaurants_score = places.count { |place| place["poi"]["categories"].include?("restaurant") }

    self.transportation_score = places.count { |place| place["poi"]["categories"].include?("public transport stop") }

    self.compute_score!
    self.save!
  end
end
