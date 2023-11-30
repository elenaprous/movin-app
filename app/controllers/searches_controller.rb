class SearchesController < ApplicationController
  def show
    @search = Search.find(params[:id])

    @markers = [{
      lat: @search.location.latitude,
      lng: @search.location.longitude,
      info_window_html: render_to_string(partial: "info_window", locals: {location: location})
    }]
  end

  def index
    @searches = current_user.searches.order(ranking: :desc)
  end
end
