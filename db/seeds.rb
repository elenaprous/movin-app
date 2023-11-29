# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Location.create!(address: "IJsbaanpad 9, 1076 CV Amsterdam")
Location.create!(address: "Marnixstraat 164-166, 1016 TG Amsterdam")
Location.create!(address: "Overtoom 301, 1054 HW Amsterdam")
Location.create!(address: "Arie Biemondstraat 111, 1054 PD Amsterdam")
Location.create!(address: "Roetersstraat 170, 1018 WE Amsterdam")
Location.create!(address: "Dijksgracht 6, 1019 BS Amsterdam")

Location.all.each do |location|
  places = HTTParty.get("https://api.tomtom.com/search/2/nearbySearch/.json\?key\=#{ENV["TOM_TOM_KEY"]}\&lat\=#{location.latitude}\&lon\=#{location.longitude}\&radius\=1000\&limit\=100")["results"]
  nightlife = places.count { |place| place["poi"]["categories"].include?("nightlife")}
  location.nightlife_info = nightlife
  gyms = places.count { |place| place["poi"]["categories"].include?("sports center")}
  location.gyms_info = gyms
  restaurants = places.count { |place| place["poi"]["categories"].include?("restaurant")}
  location.restaurants_info = restaurants
  location.save!
end

# user = User.create!(email: "admin@gmail.com", encrypted_password: "123456", first_name: "Peter", last_name: "Green")
# Search.create!(user_id: user.id, location_id: 25,)
