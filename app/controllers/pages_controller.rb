class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :preferences]

  def home
    # if current_user.nil? && params[:address].present?
    #   CACHE.write("address", params[:address], expires_in: 1.hour)
    # end
    # if CACHE.read("address")
    #   unless Location.find_by(address: CACHE.read("address"))
    #     Location.create(address: CACHE.read("address"))
    #   end
    #   CACHE.clear
    # end
  end

  def preferences
    if params[:address].present?
      unless Location.find_by(address: params["address"])
      location = Location.create(address: params["address"])
      session[:location_id] = location.id
      places = HTTParty.get("https://api.tomtom.com/search/2/nearbySearch/.json\?key\=#{ENV["TOM_TOM_KEY"]}\&lat\=#{location.latitude}\&lon\=#{location.longitude}\&radius\=500\&limit\=100")["results"]
      supermarket_count = places.count { |place| place["poi"]["categories"].include?("shop")}
      location.supermarkets_score = supermarket_count

      school_count = places.count { |place| place["poi"]["categories"].include?("school")}
      location.schools_score = school_count

      restaurant_count = places.count { |place| place["poi"]["categories"].include?("restaurant")}
      location.restaurants_score = restaurant_count

      public_transport_count = places.count { |place| place["poi"]["categories"].include?("public transport stop")}
      location.transportation_score = public_transport_count

      location.compute_score!

      location.save!
      end
    end
  end
end
