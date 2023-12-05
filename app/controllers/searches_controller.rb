class SearchesController < ApplicationController
  def show
    @search = Search.find(params[:id])

    @markers = @search.location.pois.map do |place|
      {
        lat: place.lat,
        lng: place.lon,
        info_window_html: render_to_string(partial: "poi_window", locals: { place: place })
      }
    end
    @markers << {
      lat: @search.location.latitude,
      lng: @search.location.longitude,
      info_window_html: render_to_string(partial: "info_window", locals: { location: location })
    }
  end

  def index
    @searches = current_user.searches.order(ranking: :desc)
  end
end
