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

  def edit_preferences
    user = User.find(params[:user_id])
    user.update(preferences_params)
    user.important_addresses << params[:important_addresses] unless params[:important_addresses] == ""
    user.important_addresses.flatten
    user.save
    # redirect_to searches_path
  end

  def preferences_params
    params.permit(:supermarkets_score, :schools_score, :restaurants_score, :transportation_score)
  end
end
