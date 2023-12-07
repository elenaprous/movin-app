class SearchesController < ApplicationController
  def show
    @search = Search.find(params[:id])

    @markers = @search.location.pois.map do |place|
      {
        lat: place.lat,
        lng: place.lon,
        info_window_html: render_to_string(partial: "poi_window", locals: { place: place }),
        category: place.category,
        marker_supermarkets: render_to_string(partial: "searches/markers/marker_supermarkets"),
        marker_schools: render_to_string(partial: "searches/markers/marker_schools"),
        marker_restaurants: render_to_string(partial: "searches/markers/marker_restaurants"),
        marker_transportation: render_to_string(partial: "searches/markers/marker_transportation"),
        marker_nightlife: render_to_string(partial: "searches/markers/marker_nightlife"),
        marker_gyms: render_to_string(partial: "searches/markers/marker_gyms")
      }
    end
    @markers << {
      lat: @search.location.latitude,
      lng: @search.location.longitude,
      info_window_html: render_to_string(partial: "info_window", locals: { location: location }),
      category: "address",
      marker_house: render_to_string(partial: "searches/markers/marker_house")
    }
    @markers << {
      lat: @search.address_coordinates[0],
      lng: @search.address_coordinates[1],
      info_window_html: render_to_string(partial: "info_important", locals: { location: location }),
      category: "important",
      marker_important: render_to_string(partial: "searches/markers/marker_important")
    }
  end

  def index
    @searches = current_user.searches.order(ranking: :desc)
  end
end
