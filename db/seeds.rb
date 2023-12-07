# places = HTTParty.get("https://api.tomtom.com/search/2/nearbySearch/.json\?key\=EmQlS3zwKlj8w1o6Asa2vfAf5edsPx18\&lat\=52.340900\&lon\=4.854530\&radius\=1000\&limit\=100")["results"]
# places.each do |place|
#   p place["poi"]["categories"]
# end

p "Deleting searches..."
Search.destroy_all
p "Deleting points of interest..."
Poi.destroy_all
p "Deleting users..."
User.destroy_all
p "Deleting locations..."
Location.destroy_all

p "Seeding database..."
Location.create!(address: "IJsbaanpad 9, 1076 CV, Amsterdam")
Location.create!(address: "Marnixstraat 164, 1016 TG, Amsterdam")
Location.create!(address: "Overtoom 301, 1054 HW, Amsterdam")
Location.create!(address: "Arie Biemondstraat 111, 1054 PD, Amsterdam")
Location.create!(address: "Roetersstraat 170, 1018 WE, Amsterdam")
Location.create!(address: "Dijksgracht 6, 1019 BS, Amsterdam")

user = User.create!(email: "admin@gmail.com", password: "123456", first_name: "Peter", last_name: "Green", supermarkets_score: 5, schools_score: 5, parks_score: 1, nightlife_score: 1, restaurants_score: 4, transportation_score: 3, gyms_score: 2, important_addresses: ["Burgerweeshuispad 241, 1076 GW Amsterdam", "Fred. Roeskestraat 96, 1076 ED Amsterdam"])

Location.all.each do |location|
  location.location_scores!
  search = Search.create!(user_id: user.id, location_id: location.id)
  search.compute_score_and_rank
end

p "All done!"
