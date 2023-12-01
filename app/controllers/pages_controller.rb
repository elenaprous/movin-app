class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :preferences]

  def home
  end

  def preferences
    if params[:query].present?
      unless Location.find_by(address: params[:query])
        location = Location.create(address: params[:query])
        session[:location_id] = location.id
        places = HTTParty.get("https://api.tomtom.com/search/2/nearbySearch/.json\?key\=#{ENV["TOM_TOM_KEY"]}\&lat\=#{location.latitude}\&lon\=#{location.longitude}\&radius\=500\&limit\=100")["results"]
        supermarket_count = places.count { |place| place["poi"]["categories"].include?("shop") }
        location.supermarkets_score = supermarket_count

        school_count = places.count { |place| place["poi"]["categories"].include?("school") }
        location.schools_score = school_count

        restaurant_count = places.count { |place| place["poi"]["categories"].include?("restaurant") }
        location.restaurants_score = restaurant_count

        public_transport_count = places.count { |place| place["poi"]["categories"].include?("public transport stop") }
        location.transportation_score = public_transport_count

        location.compute_score!

        location.save!
      end
    end
  end
end
