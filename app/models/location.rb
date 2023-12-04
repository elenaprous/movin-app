class Location < ApplicationRecord
  has_many :searches
  has_many :pois

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

    supermarkets = []
    schools = []
    restaurants = []
    transportations = []
    # parks = []
    nightlifes = []
    gyms = []

    places.each do |place|
      place["poi"]["categories"].include?("shop") ? supermarkets << place : nil
      place["poi"]["categories"].include?("school") ? schools << place : nil
      place["poi"]["categories"].include?("restaurant") ? restaurants << place : nil
      place["poi"]["categories"].include?("public transport stop") ? transportations << place : nil
      # parks = place["poi"]["categories"].include?("park")
      place["poi"]["categories"].include?("nightlife") ? nightlifes << place : nil
      place["poi"]["categories"].include?("fitness club center") ? gyms << place : nil
    end

    supermarkets.each { |supermarket| Poi.create!(location_id: self.id, address: supermarket["address"]["freeformAddress"], name: supermarket["poi"]["name"], category: supermarket["poi"]["categories"], lat: supermarket["position"]["lat"], lon: supermarket["position"]["lon"]) }
    schools.each { |school| Poi.create!(location_id: self.id, address: school["address"]["freeformAddress"], name: school["poi"]["name"], category: school["poi"]["categories"], lat: school["position"]["lat"], lon: school["position"]["lon"]) }
    restaurants.each { |restaurant| Poi.create!(location_id: self.id, address: restaurant["address"]["freeformAddress"], name: restaurant["poi"]["name"], category: restaurant["poi"]["categories"], lat: restaurant["position"]["lat"], lon: restaurant["position"]["lon"]) }
    transportations.each { |transportation| Poi.create!(location_id: self.id, address: transportation["address"]["freeformAddress"], name: transportation["poi"]["name"], category: transportation["poi"]["categories"], lat: transportation["position"]["lat"], lon: transportation["position"]["lon"]) }
    nightlifes.each { |nightlife| Poi.create!(location_id: self.id, address: nightlife["address"]["freeformAddress"], name: nightlife["poi"]["name"], category: nightlife["poi"]["categories"], lat: nightlife["position"]["lat"], lon: nightlife["position"]["lon"]) }
    gyms.each { |gym| Poi.create!(location_id: self.id, address: gym["address"]["freeformAddress"], name: gym["poi"]["name"], category: gym["poi"]["categories"], lat: gym["position"]["lat"], lon: gym["position"]["lon"]) }

    self.supermarkets_score = supermarkets.count
    self.schools_score = schools.count
    self.restaurants_score = restaurants.count
    self.transportation_score = transportations.count
    self.compute_score!
    self.save!
  end
end
