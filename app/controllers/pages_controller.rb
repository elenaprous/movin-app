class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :preferences]

  def home
    if current_user.nil? && params[:address].present?
      CACHE.write("address", params[:address], expires_in: 1.hour)
    end
    if CACHE.read("address")
      unless Location.find_by(address: CACHE.read("address"))
        Location.create(address: CACHE.read("address"))
      end
      CACHE.clear
    end
  end

  def preferences
    if current_user.nil? && params[:important_address].present? && params[:supermarkets_i] && params[:schools_i] && params[:restaurants_i] && params[:transportation_i]
      CACHE.write("important_address", params[:important_address], expires_in: 1.hour)
      CACHE.write("supermarkets_i", params[:supermarkets_i], expires_in: 1.hour)
      CACHE.write("schools_i", params[:schools_i], expires_in: 1.hour)
      CACHE.write("restaurants_i", params[:restaurants_i], expires_in: 1.hour)
      CACHE.write("transportation_i", params[:transportation_i], expires_in: 1.hour)
    end
  end
end
