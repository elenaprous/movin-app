class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :preferences]

  def home
    if user_signed_in? && params[:query].present?
      if Location.find_by(address: params[:query])
        location = Location.find_by(address: params[:query])
      else
        location = Location.create(address: params[:query])
        location.location_scores!
      end
      @search = Search.create!(user_id: current_user.id, location_id: location.id)
      @search.compute_score!
      redirect_to search_path(@search)
    end
  end

  def preferences
    if params[:query].present?
      if Location.find_by(address: params[:query])
        location = Location.find_by(address: params[:query])
        session[:location_id] = location.id
      else
        location = Location.create(address: params[:query])
        session[:location_id] = location.id
        location.location_scores!
      end
    end
  end
end
