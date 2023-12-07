puts "Deleting searches..."
Search.destroy_all
puts "Deleting points of interest..."
Poi.destroy_all
puts "Deleting users..."
User.destroy_all
puts "Deleting locations..."
Location.destroy_all

puts "Seeding database..."
Location.create!(address: "IJsbaanpad 9, 1076 CV, Amsterdam")
Location.create!(address: "Marnixstraat 164, 1016 TG, Amsterdam")
Location.create!(address: "Overtoom 301, 1054 HW, Amsterdam")
Location.create!(address: "Arie Biemondstraat 111, 1054 PD, Amsterdam")
Location.create!(address: "Roetersstraat 170, 1018 WE, Amsterdam")
Location.create!(address: "Dijksgracht 6, 1019 BS, Amsterdam")

user = User.create!(email: "tobias@movin.today", password: "cats123", first_name: "Tobias", last_name: "Groenland", supermarkets_score: 2, schools_score: 5, parks_score: 1, nightlife_score: 1, restaurants_score: 4, transportation_score: 2, gyms_score: 4, important_addresses: ["Kanaalstraat 132 H, 1054 XN Amsterdam", "Fred. Roeskestraat 96, 1076 ED Amsterdam"])
user2 = User.create!(email: "admin@gmail.com", password: "123456", first_name: "Tobias", last_name: "Groenland", supermarkets_score: 2, schools_score: 5, parks_score: 1, nightlife_score: 1, restaurants_score: 4, transportation_score: 2, gyms_score: 4, important_addresses: ["Kanaalstraat 132 H, 1054 XN Amsterdam", "Fred. Roeskestraat 96, 1076 ED Amsterdam"])

Location.all.each do |location|
  location.location_scores!
  search = Search.create!(user_id: user.id, location_id: location.id)
  search.compute_score_and_rank
end

Location.all.each do |location|
  location.location_scores!
  search = Search.create!(user_id: user2.id, location_id: location.id)
  search.compute_score_and_rank
end

puts "All done!"
