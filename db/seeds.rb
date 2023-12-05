# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# places = HTTParty.get("https://api.tomtom.com/search/2/nearbySearch/.json\?key\=EmQlS3zwKlj8w1o6Asa2vfAf5edsPx18\&lat\=52.340900\&lon\=4.854530\&radius\=1000\&limit\=100")["results"]

# places.each do |place|
#   p place["poi"]["categories"]
# end

User.destroy_all
Location.destroy_all
Search.destroy_all

Location.create!(address: "IJsbaanpad 9, 1076 CV, Amsterdam")
Location.create!(address: "Marnixstraat 164-166, 1016 TG, Amsterdam")
Location.create!(address: "Overtoom 301, 1054 HW, Amsterdam")
Location.create!(address: "Arie Biemondstraat 111, 1054 PD, Amsterdam")
Location.create!(address: "Roetersstraat 170, 1018 WE, Amsterdam")
Location.create!(address: "Dijksgracht 6, 1019 BS, Amsterdam")

user = User.create!(email: "admin@gmail.com", password: "123456", first_name: "Peter", last_name: "Green", supermarkets_score: 1, schools_score: 5, parks_score: 2, nightlife_score: 1, restaurants_score: 4, transportation_score: 3, gyms_score: 2)

Location.all.each do |location|
  places = HTTParty.get("https://api.tomtom.com/search/2/nearbySearch/.json\?key\=#{ENV["TOM_TOM_KEY"]}\&lat\=#{location.latitude}\&lon\=#{location.longitude}\&radius\=500\&limit\=100")["results"]
  supermarket_count = places.count { |place| place["poi"]["categories"].include?("market")}
  location.supermarkets_score = supermarket_count

  school_count = places.count { |place| place["poi"]["categories"].include?("school")}
  location.schools_score = school_count

  restaurant_count = places.count { |place| place["poi"]["categories"].include?("restaurant")}
  location.restaurants_score = restaurant_count

  public_transport_count = places.count { |place| place["poi"]["categories"].include?("public transport stop")}
  location.transportation_score = public_transport_count

  location.compute_score!

  location.save!

  search = Search.create!(user_id: user.id, location_id: location.id)
  search.compute_score!
end
