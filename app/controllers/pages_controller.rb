class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

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
  end
end
