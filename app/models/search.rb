class Search < ApplicationRecord
  belongs_to :user
  belongs_to :location

  def compute_score_and_rank
    compute_score!()
    compute_rank!()
    compute_distance!() if self.user.important_addresses.count.positive?
  end

  def address_coordinates
    user_important_address = self.user.important_addresses.first
    user_address_geocoded  = Geocoder.search(user_important_address).first.coordinates
    [user_address_geocoded[0], user_address_geocoded[1]]
  end

  private

  ## REF https://developer.tomtom.com/routing-api/documentation/routing/calculate-route ##
  def compute_distance!
    user_important_address = self.user.important_addresses.first
    user_address_geocoded  = Geocoder.search(user_important_address).first.coordinates
    user_lat, user_lng     = user_address_geocoded[0], user_address_geocoded[1]

    location_lat, location_lng = self.location.latitude, self.location.longitude

    distance_mt = HTTParty.get("https://api.tomtom.com/routing/1/calculateRoute/#{user_lat},#{user_lng}:#{location_lat},#{location_lng}/json?&key=#{ENV["TOM_TOM_KEY"]}")["routes"][0]["summary"]["lengthInMeters"]

    if distance_mt <= 750
      score = 1
    elsif distance_mt > 750 && distance_mt <= 2000
      score = 0
    else
      score = -1
    end

    self.update(distance_score: score, distance: distance_mt)
  end

  def compute_rank!
    columns = Search.columns
    .select { |col| col.name.include?("score") }
    .reject { |col| col.name.include?("distance" )}

    total   = 0

    columns.each do |col|
      column = col.name
      value = self.send(column)

      total += value
    end

    self.update(ranking: total)
  end

  def compute_score!
    columns = Search.columns
    .select { |col| col.name.include?("score") }
    .reject { |col| col.name.include?("distance")}

    columns.each do |col|
      col = col.name

      score_from_user     = self.user.send(col) || 1
      score_from_location = self.location.send(col) || 1

      self.update(col => score_from_user * score_from_location)
    end
  end
end
